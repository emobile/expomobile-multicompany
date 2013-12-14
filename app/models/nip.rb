class Nip < ActiveRecord::Base
  attr_accessible :attendee_id, :nip, :sent, :times_sent, :event_id
  belongs_to :attendee
  belongs_to :event
  
  validates :nip, :attendee_id, :event_id, :presence => true
  validates_format_of :attendee_id, :with => /\A\d+\z/
  validates_numericality_of :times_sent, :numericality => true, :if => :times_sent?
end