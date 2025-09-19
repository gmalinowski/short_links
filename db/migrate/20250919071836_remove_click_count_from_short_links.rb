class RemoveClickCountFromShortLinks < ActiveRecord::Migration[8.0]
  def change
    remove_column :short_links, :click_count
  end
end
