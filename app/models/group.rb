class Group < ActiveRecord::Base
  attr_accessible :name, :event_id
  has_many :subgroups, :dependent => :destroy
  belongs_to :event
  
  validates :name, :event_id, :presence => true
end