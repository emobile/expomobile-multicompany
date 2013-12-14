class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name,                                   :null => false
      t.datetime :start_date,                           :null => false
      t.datetime :end_date,                             :null => false
      t.string :place,                                  :null => false
      t.text :observations
      t.references :event,                              :null => false

      t.timestamps
    end
    add_foreign_key :activities, :events, :name => :activities_event_id_fk
  end
end