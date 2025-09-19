class LinkClick < ApplicationRecord
  belongs_to :short_link

  after_create_commit do
    broadcast_replace_to "short_links",
                         target: "link_clicks_count_#{short_link.id}",
                         partial: "short_links/link_count",
                         locals: {
                           short_link: short_link
                         }
  end
end
