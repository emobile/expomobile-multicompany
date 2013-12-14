class CreateAttendeeWorkshops < ActiveRecord::Migration
  def change
    create_table :attendee_workshops do |t|
      t.references :attendee,                   :null => false
      t.references :workshop,                   :null => false
      t.references :event,                      :null => false

      t.timestamps
    end
    add_foreign_key :attendee_workshops, :attendees, :name => :attendee_workshops_attendee_id_fk
    add_foreign_key :attendee_workshops, :workshops, :name => :attendee_workshops_workshop_id_fk
    add_foreign_key :attendee_workshops, :events, :name => :attendee_workshops_event_id_fk
  end
end