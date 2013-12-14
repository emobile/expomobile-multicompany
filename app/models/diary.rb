class Diary < ActiveRecord::Base
  attr_accessible :event_date, :event_end_date, :event_type, :description, :place, :event_id
  belongs_to :event
  
  validates :event_date, :event_end_date, :event_type, :description, :place, :event_id, :presence => true
  validates_datetime :event_date, :event_end_date, :if => :event_date? && :event_end_date?
  validate :start_date_less_than_end_date, :if => :event_date? && :event_end_date?
  
  private
  
  def start_date_less_than_end_date
    if event_date > event_end_date
      errors.add(:event_date, :not_less_than_end_date)
    end
  end
end
