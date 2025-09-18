class AllowNullOnShortcode < ActiveRecord::Migration[8.0]
  def change
    change_column :short_links, :shortcode, :string, null: true
  end
end
