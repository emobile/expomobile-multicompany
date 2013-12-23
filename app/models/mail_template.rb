class MailTemplate < ActiveRecord::Base
  attr_accessible :name, :content, :event_id
  belongs_to :event
  
  validates :name, :content, :presence => true
  validates :name, :uniqueness => true
  
  def to_param
    [id, name.parameterize].join("-")
  end
end