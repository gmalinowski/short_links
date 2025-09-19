class AddColumnToShortLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :short_links, :click_count, :integer, default: 0, null: false
  end
end
