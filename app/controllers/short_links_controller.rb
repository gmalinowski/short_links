class ShortLinksController < ApplicationController
  before_action :set_short_links

  def index
    @short_link = ShortLink.new

    @short_links.each(&:enqueue_preview_job_if_stale)
  end

  def redirect
    short_link = ShortLink.find_by!(shortcode: params[:short_code])

    link_click = short_link.link_clicks.new(user_agent: request.user_agent)
    link_click.save || Rails.logger.warn("Failed to save click for short_link.id:#{short_link.id}")
    redirect_to short_link.original_url, allow_other_host: true
  end

  def create
    @short_link = ShortLink.new(short_link_params)
    if @short_link.save
      GenerateLinkPreviewJob.perform_later(@short_link.id)
      render turbo_stream: [
        turbo_stream.prepend("flash_messages", partial: "shared/alert", locals: {
          message: "Short link created.",
          type: "info"
        }),
        turbo_stream.replace("short_link_form", partial: "form", locals: { short_link: ShortLink.new })
      ]
    else
      render turbo_stream: turbo_stream.replace("short_link_form", partial: "form", locals: { short_link: @short_link })
    end
  end

  def destroy
    @short_link = ShortLink.find(params[:id])
    @short_link.destroy!
    render turbo_stream: turbo_stream.prepend("flash_messages", partial: "shared/alert", locals: {
      message: "Short link deleted.",
      type: "warning"
    })
  end

  private

  def set_short_links
    short_links_arel = ShortLink.arel_table
    link_clicks_arel = LinkClick.arel_table

    @short_links = ShortLink
                     .left_joins(:link_clicks)
                     .group(short_links_arel[:id])
                     .order(link_clicks_arel[:id].count.desc)
                     .order(short_links_arel[:updated_at].desc)

  end

  def short_link_params
    params.require(:short_link).permit(:original_url)
  end
end