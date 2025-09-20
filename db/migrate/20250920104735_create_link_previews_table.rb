class CreateLinkPreviewsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :link_previews do |t|
      t.references :short_link, null: false, foreign_key: { on_delete: :cascade }, index: { unique: true }
      t.string :title
      t.text :description
      t.string :favicon

      t.timestamps
    end

    create_table :link_previews_images do |t|
      t.references :link_preview, null: false, foreign_key: { on_delete: :cascade }
      t.string :src

      t.timestamps
    end
  end
end
