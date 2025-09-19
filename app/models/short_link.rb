class ShortLink < ApplicationRecord
  has_many :link_clicks

  validates :original_url, presence: true, uniqueness: true
  validates :shortcode, presence: false, uniqueness: true

  after_create :set_shortcode

  after_create_commit -> { broadcast_prepend_later_to "short_links" }
  after_update_commit -> { broadcast_prepend_later_to "short_links" }
  after_destroy_commit -> { broadcast_remove_to "short_links" }

  private

  def set_shortcode
    shortcode = (self.original_url).then &Digest::MD5.method(:hexdigest)
    update_column(:shortcode, shortcode[..5])
  end
end
