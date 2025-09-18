class ShortLink < ApplicationRecord
  validates :original_url, presence: true, uniqueness: true
  validates :shortcode, presence: false, uniqueness: true

  after_create :set_shortcode

  private

  def set_shortcode
    shortcode = (self.original_url).then &Digest::MD5.method(:hexdigest)
    update_column(:shortcode, shortcode[..5])
  end
end
