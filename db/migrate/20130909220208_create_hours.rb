class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.datetime :start_date,          :null => false
      t.datetime :end_date,            :null => false
      t.references :event,             :null => false

      t.timestamps
    end
    add_foreign_key :hours, :events, :name => :hours_event_id_fk
  end
end