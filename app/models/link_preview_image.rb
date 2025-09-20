class LinkPreviewImage < ApplicationRecord
  belongs_to :link_preview

  after_create_commit :broadcast_to_short_link_preview

  private
  def broadcast_to_short_link_preview
    broadcast_replace_to(
      "short_links",
      target: "short_link_preview_image_link_preview_id_#{link_preview.id}",
      partial: "shared/link_preview_image",
      locals: { link_preview_images: link_preview.link_preview_images }
    )
  end
end
