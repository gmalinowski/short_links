class ShortLink < ApplicationRecord
  has_many :link_clicks, dependent: :destroy
  has_one :link_preview, dependent: :destroy

  validates :original_url, presence: true, uniqueness: true
  validates :shortcode, presence: false, uniqueness: true

  after_create :set_shortcode

  after_create_commit -> { broadcast_prepend_later_to "short_links" }
  after_update_commit -> { broadcast_prepend_later_to "short_links" }
  after_destroy_commit -> { broadcast_remove_to "short_links" }

  def enqueue_preview_job_if_stale
    if link_preview.nil? || link_preview.updated_at < 5.minutes.ago
      GenerateLinkPreviewJob.perform_later(id)
    end
  end

  private

  def set_shortcode
    shortcode = (self.original_url).then &Digest::MD5.method(:hexdigest)
    update_column(:shortcode, shortcode[..5])
  end
end
