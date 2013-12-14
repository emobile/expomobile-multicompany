class AttendeeExposition < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :expositor
  belongs_to :event
  
  attr_accessible :attendee_id, :exhibitor_id, :event_id
  
  validates :attendee_id, :exhibitor_id, :event_id, :presence => true
end
