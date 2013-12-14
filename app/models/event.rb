class Event < ActiveRecord::Base
  attr_accessible :banner, :exposition_tolerance, :has_activity, :has_conference, :has_facetoface, :has_offert, :has_workshop, :language, :logo, :name, :r_city, :r_country, :r_email, :r_enterprise, :r_job, :r_name, :r_phone, :r_social_reason, :r_state, :r_work_colony, :r_work_street, :r_work_street_number, :r_work_zip, :time_zone, :workshop_tolerance, :start_date, :end_date, :is_free, :place, :e_work_street, :e_work_street_number, :e_work_colony, :e_work_zip, :e_city, :e_state, :e_country
  has_many :groups, :dependent => :destroy
  has_many :subgroups
  has_many :attendees
  has_many :massive_loads, :dependent => :destroy
  has_many :workshops
  has_many :rooms, :dependent => :destroy
  has_many :hours, :dependent => :destroy
  has_many :expositions, :dependent => :destroy
  has_many :exhibitors, :dependent => :destroy
  has_many :offerts
  has_many :face_to_faces
  has_many :sponsors, :dependent => :destroy
  has_many :diaries, :dependent => :destroy
  has_many :conferences, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :users, :dependent => :destroy
  has_many :attendee_expositions
  has_many :attendee_workshops
  has_many :nips
  
  has_attached_file :logo,
    :styles => {:medium => "x300",
    :thumb => "x100"},
    :default_url => "/assets/missing.jpg"
  has_attached_file :banner,
    :styles => {:medium => "x300",
    :thumb => "x100"},
    :default_url => "/assets/missing.jpg"
  validates :banner, :logo, :name, :r_email, :r_enterprise, :r_name, :r_social_reason, :start_date, :end_date, :place, :presence => true
  validates_numericality_of :r_work_zip, :if => :r_work_zip
  
  def to_param
    [id, name.parameterize].join("-")
  end
end