class MassiveLoad < ActiveRecord::Base
  attr_accessible :excel_file, :event_id
  belongs_to :event
  has_attached_file :excel_file
  
  validates_attachment_presence :excel_file
  validates :event_id, :presence => true
end