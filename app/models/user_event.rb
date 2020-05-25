class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  enum status: { unattend: 0, attended: 1 }
  FEMALE_DISCOUNT = 5

  validate :multiple_registrations, on: :create
  validate :valid_event

  before_create do
    self.status = :attended
    if user.female?
      self.ticket_fee = ((100 - FEMALE_DISCOUNT) * event.ticket_fee) / 100
    end
  end

  def unattend
    update(status: :unattend)
  end

  def can_attend?
    unattend?
  end

  def can_unattend?
    attended?
  end

  def valid_event
    if event.timing.in_time_zone('Kolkata') < Time.now.in_time_zone('Kolkata')
      errors.add(:error, 'You cannot attend/unattend for past event')
    end
  end

  def multiple_registrations
    if event.user_events.where(user_id: user.id, status: 1).exists?
      errors.add(:error, 'You cannot register for same event multiple times')
    end
  end
end
