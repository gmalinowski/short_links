class CreateLinkClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :link_clicks do |t|
      t.references :short_link, null: false, foreign_key: true
      t.timestamps
    end
  end
end
