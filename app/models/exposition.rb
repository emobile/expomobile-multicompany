class Exposition < ActiveRecord::Base
  attr_accessible :name, :end_date, :start_date, :location, :observations, :exposition_key, :event_id
  cattr_accessor :action
  belongs_to :event
  
  validates :name, :end_date, :location, :start_date, :event_id, :presence => true
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