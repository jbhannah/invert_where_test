class Foobar < ApplicationRecord
  after_initialize :set_expires_at

  scope :active, -> { where(expires_at: Time.zone.now..) }
  scope :expired_inverse_of, -> { inverse_of(:active) }
  scope :expired_invert_where, -> { active.invert_where }

  scope :published, -> { where(published: true) }
  scope :draft_inverse_of, -> { inverse_of(:published) }
  scope :draft_invert_where, -> { published.invert_where }

  private
  def set_expires_at
    self.expires_at ||= 30.days.from_now
  end
end
