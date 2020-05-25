class Event < ApplicationRecord
  has_many :user_events

  def valid_event?
    timing.in_time_zone('Kolkata') > Time.now.in_time_zone('Kolkata')
  end
end
