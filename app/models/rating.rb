class Rating < ActiveRecord::Base
  attr_accessible :value, :comment
  
  validate :value, :presence => true
end
