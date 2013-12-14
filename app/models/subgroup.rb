class Subgroup < ActiveRecord::Base
  attr_accessible :name, :leader, :subgroup_key, :group_id, :event_id
  belongs_to :group
  belongs_to :event
  has_many :schedules, :dependent => :destroy
  has_many :workshops, :through => :schedules
  has_many :hours, :through => :schedules
  has_many :attendees, :dependent => :destroy
  
  validates :name, :leader, :subgroup_key, :group_id, :event_id, :presence => true
end