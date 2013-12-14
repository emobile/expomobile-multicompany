class FaceToFace < ActiveRecord::Base
  attr_accessible :attendee_id, :end_date, :int_contact, :int_job, :int_name, :start_date, :subject, :event_id
  cattr_accessor :action
  belongs_to :event
  belongs_to :attendee
  belongs_to :interviewee 

  validates :attendee_id, :end_date, :int_contact, :int_job, :int_name, :start_date, :subject, :event_id, :presence => true
  validates_datetime :end_date, :if => :end_date
  validates_datetime :start_date, :if => :start_date
  validate :date_not_overlaps, :if => :start_date? && :end_date?
  validate :start_date_less_than_end_date, :if => :start_date? && :end_date?
  
  private
  
  def date_not_overlaps
    overlaps = []
    if action == "update"
      overlaps = FaceToFace.where("start_date < ? AND end_date > ? AND int_contact LIKE ? AND id != ?", end_date, start_date, int_contact, id)
    else
      overlaps = FaceToFace.where("start_date < ? AND end_date > ? AND int_contact LIKE ?", end_date, start_date, int_contact)
    end
    if overlaps.any?
      errors.add(:base, :overlaps)
    end
  end
  
  def start_date_less_than_end_date
    if start_date > end_date
      errors.add(:start_date, :not_less_than_end_date)
    end
  end
  

end