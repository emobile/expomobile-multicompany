class Sponsor < ActiveRecord::Base
  attr_accessible :name, :email, :contact, :job, :phone, :social_reason, :twitter, :web_page, :work_street, :work_street_number, :work_colony, :work_zip, :logo, :event_id
  belongs_to :event
  has_attached_file :logo,
    :styles => {:medium => "x300",
    :thumb => "x100",
    :mobile => "x60"},
    :default_url => "/assets/missing.jpg"
  before_save :name_to_upcase
  
  validates :name, :phone, :email, :social_reason, :contact, :job, :event_id, :presence => true
  validates :name, :uniqueness => true
  
  private
  
  def name_to_upcase
    self.name.mb_chars.upcase! if !name.nil?
    self.social_reason.mb_chars.upcase! if !social_reason.nil?
  end
end