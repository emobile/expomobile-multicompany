class CreateFaceToFaces < ActiveRecord::Migration
  def change
    create_table :face_to_faces do |t|
      t.references :attendee,                               :null => false
      t.string :int_contact,                                :null => false
      t.string :int_job,                                    :null => false
      t.string :int_name,                                   :null => false
      t.string :subject,                                    :null => false
      t.datetime :start_date,                               :null => false
      t.datetime :end_date,                                 :null => false
      t.references :event,                                  :null => false

      t.timestamps
    end
    add_foreign_key :face_to_faces, :attendees, :name => :face_to_faces_attendee_id_fk
    add_foreign_key :face_to_faces, :events, :name => :face_to_faces_event_id_fk
  end
end