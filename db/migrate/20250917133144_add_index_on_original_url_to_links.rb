class AddIndexOnOriginalUrlToLinks < ActiveRecord::Migration[8.0]
  def change
    add_index :links, :original_url, unique: true
  end
end
