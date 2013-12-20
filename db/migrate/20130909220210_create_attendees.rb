class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :attendee_id,             :null => false
      t.string :e_name,                  :null => false
      t.string :e_tradename,             :null => false
      t.string :e_street,                :null => false
      t.integer :e_ext_number,           :null => false
      t.string :e_int_number
      t.string :e_colony,                :null => false
      t.string :e_municipality,          :null => false
      t.string :e_city,                  :null => false
      t.string :e_state,                 :null => false
      t.integer :e_zip_code,             :null => false
      t.string :e_rfc,                   :null => false
      t.integer :e_lada,                 :null => false
      t.string :e_phone,                 :null => false
      t.string :a_name,                  :null => false
      t.string :a_email,                 :null => false
      t.string :a_chat
      t.string :a_cellphone,             :null => false
      t.string :a_tel_nextel
      t.string :a_radio_nextel
      t.boolean :a_is_director,          :null => false, :default => false
      t.string :a_platform,              :null => false
      t.string :e_main_line
      t.string :a_sec_line
      t.integer :a_num_employees,        :null => false
      t.string :a_other_line
      t.string :a_web
      t.string :a_market_segment,        :null => false
      t.boolean :confirmed,              :null => false, :default => false
      t.string :confirmation_token,      :null => false
      t.references :subgroup,            :null => false
      t.references :event,               :null => false

      t.timestamps
    end
    add_foreign_key :attendees, :subgroups, :name => :attendees_subgroup_id_fk
    add_foreign_key :attendees, :events, :name => :attendees_event_id_fk
  end
end
