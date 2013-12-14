class Room < ActiveRecord::Base
  attr_accessible :name, :room_key, :event_id
  belongs_to :event
  has_one :workshop
  
  validates :name, :room_key, :event_id, :presence => true
  before_destroy :room_with_workshop?

  private

  def room_with_workshop?
    return workshop.nil?
  end
end