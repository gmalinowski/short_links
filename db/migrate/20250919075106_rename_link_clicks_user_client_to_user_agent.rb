class RenameLinkClicksUserClientToUserAgent < ActiveRecord::Migration[8.0]
  def change
    rename_column :link_clicks, :user_client, :user_agent
  end
end
