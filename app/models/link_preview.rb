class LinkPreview < ApplicationRecord
  belongs_to :short_link
  has_many :link_preview_images

  after_commit :broadcast_to_short_link

  private
  def broadcast_to_short_link
    broadcast_replace_to(
      "short_links",
      target: "short_link_preview_short_link_id_#{short_link.id}",
      partial: "shared/link_preview",
      locals: { short_link: short_link }
    )
  end
end
