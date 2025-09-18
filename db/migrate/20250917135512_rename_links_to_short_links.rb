class RenameLinksToShortLinks < ActiveRecord::Migration[8.0]
  def change
    rename_table :links, :short_links
  end
end
