class Role < ActiveRecord::Base
  attr_accessible :is_super_admin, :name
  has_many :users, :dependent => :destroy
end
