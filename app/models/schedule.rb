class Schedule < ActiveRecord::Base
  attr_accessible :workshop_id, :subgroup_id, :hour_id
  belongs_to :workshop
  belongs_to :subgroup
  belongs_to :hour
  
  validates :workshop_id, :subgroup_id, :hour_id, :presence => true
  validates :workshop_id, :uniqueness => {:scope => :subgroup_id}
  validates :subgroup_id, :uniqueness => {:scope => :hour_id}
  validates :workshop_id, :uniqueness => {:scope => :hour_id}
end