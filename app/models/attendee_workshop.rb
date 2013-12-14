class AttendeeWorkshop < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :workshop
  belongs_to :event
  
  attr_accessible :attendee_id, :workshop_id, :event_id
  
  validates :attendee_id, :workshop_id, :event_id, :presence => true
end