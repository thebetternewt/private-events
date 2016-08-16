class User < ApplicationRecord
  has_many :events, class_name: 'Event', foreign_key: "creator_id"
  has_many :event_attendances, foreign_key: "attendee_id"
  has_many :attended_events, through: :event_attendances

  def previous_events
    previous_created_events = self.events.where("begin_date < ?", Time.zone.now)
    previously_attended_events = self.attended_events.where("begin_date < ?", Time.zone.now)
    (previous_created_events + previously_attended_events).uniq
  end

  def upcoming_events
    upcoming_created_events = self.events.where("begin_date > ?", Time.zone.now)
    upcoming_attended_events = self.attended_events.where("begin_date > ?", Time.zone.now)
    (upcoming_created_events + upcoming_attended_events).uniq
  end
end
