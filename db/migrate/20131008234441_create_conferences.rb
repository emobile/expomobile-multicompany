class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name,                                 :null => false
      t.string :conferencist,                         :null => false
      t.datetime :start_date,                         :null => false
      t.datetime :end_date,                           :null => false
      t.string :place,                                :null => false
      t.text :observations
      t.references :event,                            :null => false

      t.timestamps
    end
    add_foreign_key :conferences, :events, :name => :conferences_event_id_fk
  end
end
