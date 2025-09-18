class ShortLinksController < ApplicationController
  before_action :set_short_links

  def index
    @short_link = ShortLink.new

  end

  def create
    @short_link = ShortLink.new(short_link_params)
    if @short_link.save
      flash.now[:notice] = "Short link created"
      render turbo_stream: turbo_stream.prepend("flash_messages", partial: "shared/alert", locals: {
        message: "Short link created.",
        type: "info"
      })
    else
      render turbo_stream: turbo_stream.replace("short_link_form", partial: "form", locals: { short_link: @short_link })
    end
  end


  private

  def set_short_links
    @short_links = ShortLink.all.order(created_at: :desc)
  end
  def short_link_params
    params.require(:short_link).permit(:original_url)
  end
end