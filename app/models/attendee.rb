class Attendee < ActiveRecord::Base
  attr_accessible :attendee_id, :a_cellphone, :a_chat, :a_email, :a_is_director, :a_market_segment, :a_name, :a_num_employees, :a_other_line, :a_platform, :a_radio_nextel, :a_sec_line, :a_tel_nextel, :a_web, :e_city, :e_colony, :e_ext_number, :e_int_number, :e_lada, :e_main_line, :e_municipality, :e_name, :e_phone, :e_rfc, :e_state, :e_street, :e_tradename, :e_zip_code, :subgroup_id, :event_id
  has_one :nip, :dependent => :destroy
  belongs_to :subgroup
  belongs_to :event
  has_many :schedules, :through => :subgroup
  has_many :hours, :through => :schedules
  has_many :workshops, :through => :schedules
  has_many :face_to_faces, :dependent => :destroy
  has_many :attendee_expositions, :dependent => :destroy
  has_many :attendee_workshops, :dependent => :destroy
  
  validates :a_cellphone, :a_email, :a_market_segment, :a_name, :a_num_employees, :a_platform, :e_city, :e_colony, :e_ext_number, :e_lada, :e_municipality, :e_name, :e_phone, :e_rfc, :e_state, :e_street, :e_tradename, :e_zip_code, :event_id, :presence => true
  validates_numericality_of :a_num_employees, :if => :a_num_employees
  validates_numericality_of :e_ext_number, :if => :e_ext_number
  validates_numericality_of :e_zip_code, :if => :e_zip_code
  validates_numericality_of :e_lada, :if => :e_lada
  validates_format_of :attendee_id, :with => /\A[A-Z]{2}\d{4}\z/, :if => :attendee_id
  validates :attendee_id, :uniqueness => { :scope => :event_id }
end