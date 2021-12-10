class Foobar < ApplicationRecord
  after_initialize :set_expires_at

  scope :active, -> { where(expires_at: Time.zone.now..) }
  scope :expired_invert_where, -> { active.invert_where }

  private
  def set_expires_at
    self.expires_at ||= 30.days.from_now
  end
end
