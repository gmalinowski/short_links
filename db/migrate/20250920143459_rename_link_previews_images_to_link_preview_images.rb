class RenameLinkPreviewsImagesToLinkPreviewImages < ActiveRecord::Migration[8.0]
  def change
    rename_table :link_previews_images, :link_preview_images
  end
end
