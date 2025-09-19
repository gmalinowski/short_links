class AddUserClientToLinkClicks < ActiveRecord::Migration[8.0]
  def change
    add_column :link_clicks, :user_client, :string
  end
end
