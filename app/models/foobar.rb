class Foobar < ApplicationRecord
  after_initialize :set_expires_at

  private
  def set_expires_at
    self.expires_at ||= 30.days.from_now
  end
end
