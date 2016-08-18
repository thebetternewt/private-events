class User < ApplicationRecord
  has_many :events, class_name: 'Event', foreign_key: "creator_id"

  has_many :event_attendances, foreign_key: "attendee_id"
  has_many :attended_events, through: :event_attendances

  has_many :invitations, foreign_key: "invitee_id"
  has_many :event_invites, through: :invitations, source: "event"

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

  def invite(user, event)
    Invitation.create(event: event, invitee_id: user.id)
  end

  def invited?(event)
    Invitation.exists?(event: event, invitee_id: self.id)
  end

  def attending?(event)
    self.attended_events.exists?(event.id)
  end

  def attend(event)
    self.event_attendances.create(attended_event_id: event.id)
  end

end
