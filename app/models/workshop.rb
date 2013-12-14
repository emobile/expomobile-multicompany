class Workshop < ActiveRecord::Base
  attr_accessible :name, :workshop_key, :room_id, :teacher_name, :event_id
  belongs_to :event
  belongs_to :room
  has_many :schedules, :dependent => :destroy
  has_many :subgroups, :through => :schedules
  has_many :hours, :through => :schedules
  has_many :attendee_workshops, :dependent => :destroy
  
  validates :name, :workshop_key, :room_id, :teacher_name, :event_id, :presence => true
  validates :room_id, :uniqueness => true
  before_destroy :workshop_with_subgroups?
  
  private
  
  def workshop_with_subgroups?
    return subgroups.blank?
  end
end