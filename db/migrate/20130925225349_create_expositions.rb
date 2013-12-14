class CreateExpositions < ActiveRecord::Migration
  def change
    create_table :expositions do |t|
      t.string :name,                        :null => false
      t.string :location ,                   :null => false
      t.string :observations
      t.datetime :start_date,                :null => false
      t.datetime :end_date,                  :null => false
      t.references :event,                   :null => false

      t.timestamps
    end
    add_foreign_key :expositions, :events, :name => :expositions_event_id_fk
  end
end