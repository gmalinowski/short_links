class AddOnDeleteCascadeToShortLinks < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :link_clicks, :short_links

    add_foreign_key :link_clicks, :short_links, on_delete: :cascade
  end
end
