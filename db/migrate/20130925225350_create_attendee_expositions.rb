class CreateAttendeeExpositions < ActiveRecord::Migration
  def change
    create_table :attendee_expositions do |t|
      t.references :attendee,                  :null => false
      t.references :exhibitor,                 :null => false
      t.references :event,                     :null => false

      t.timestamps
    end
    add_foreign_key :attendee_expositions, :attendees, :name => :attendee_expositions_attendee_id_fk
    add_foreign_key :attendee_expositions, :exhibitors, :name => :attendee_expositions_exhibitor_id
    add_foreign_key :attendee_expositions, :events, :name => :attendee_expositions_event_id_fk
  end
end