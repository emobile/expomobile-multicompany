class SystemConfiguration < ActiveRecord::Base
  attr_accessible :token, :language
  validates :token, :language, :presence => true
end