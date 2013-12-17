class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name,                                   :null => false
      t.string :r_name,                                 :null => false
      t.string :r_enterprise,                           :null => false
      t.string :r_social_reason,                        :null => false
      t.string :r_phone
      t.string :r_email,                                :null => false
      t.string :r_job
      t.string :r_work_street
      t.string :r_work_street_number
      t.string :r_work_colony
      t.string :r_work_zip
      t.string :r_city
      t.string :r_state
      t.string :r_country
      t.string :language
      t.string :time_zone
      t.integer :workshop_tolerance
      t.boolean :has_activity
      t.boolean :has_conference
      t.boolean :has_facetoface
      t.boolean :has_offert
      t.boolean :has_workshop
      t.datetime :start_date,                           :null => false
      t.datetime :end_date,                             :null => false
      t.boolean :is_free,                               :null => false, :default => true
      t.string :place,                                  :null => false
      t.string :e_work_street
      t.string :e_work_street_number
      t.string :e_work_colony
      t.string :e_work_zip
      t.string :e_city
      t.string :e_state
      t.string :e_country
      t.string :token_for_id,                           :null => false

      t.timestamps
    end
  end
end