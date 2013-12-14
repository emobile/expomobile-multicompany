class Offert < ActiveRecord::Base
  attr_accessible :description, :end_date, :exhibitor_id, :price, :start_date, :location, :event_id
  belongs_to :event
  belongs_to :exhibitor
  
  validates :description, :end_date, :exhibitor_id, :price, :start_date, :location, :event_id, :presence => true
  validates_datetime :end_date, :if => :end_date
  validates_datetime :start_date, :if => :start_date
  validate :start_date_less_than_end_date, :if => :start_date? && :end_date?
  
  private
  
  def start_date_less_than_end_date
    if start_date > end_date
      errors.add(:start_date, :not_less_than_end_date)
    end
  end
end