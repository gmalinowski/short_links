class GenerateLinkPreviewJob < ApplicationJob
  queue_as :urgent

  def perform(short_link_id)
    short_link = ShortLink.find(short_link_id)

    begin
      preview = LinkThumbnailer.generate(short_link.original_url)

      link_preview = short_link.link_preview || short_link.build_link_preview
      link_preview.update!(
        title: preview.title,
        description: preview.description,
        favicon: preview.favicon
      )

      link_preview.link_preview_images.destroy_all

      Rails.logger.info("Images: #{preview.images.inspect}")
      preview.images.each do |img|
        link_preview.link_preview_images.create!(src: img.to_s)
      end

    rescue LinkThumbnailer::Exceptions => e
      Rails.logger.warn("Couldnt generate preview for ShortLink #{short_link.id}: #{e.message}")
    end
  end
end
