class Conference < ActiveRecord::Base
  attr_accessible :conferencist, :end_date, :name, :observations, :place, :start_date, :photo, :event_id
  belongs_to :event
  has_attached_file :photo,
    :styles => {:medium => "x300",
    :thumb => "x100",
    :mobile => "x60" },
    :convert_options => { :all => "-colorspace Gray" },
    :default_url => "/assets/missing.jpg"
  validates :name, :conferencist, :end_date, :start_date, :place, :event_id, :presence => true
  validates_datetime :end_date, :if => :end_date?
  validates_datetime :start_date, :if => :start_date?
  validate :start_date_less_than_end_date, :if => :start_date? && :end_date?
  
  private
  
  def start_date_less_than_end_date
    if start_date > end_date
      errors.add(:start_date, :not_less_than_end_date)
    end
  end
end