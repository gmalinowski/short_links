class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.text :original_url, null: false
      t.string :shortcode, null: false

      t.timestamps

    end

    add_index :links, :shortcode, unique: true
  end
end
