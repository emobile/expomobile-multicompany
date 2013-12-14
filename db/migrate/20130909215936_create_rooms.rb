class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name,              :null => false
      t.string :room_key,          :null => false
      t.references :event,         :null => false

      t.timestamps
    end
    add_foreign_key :rooms, :events, :name => :rooms_event_id_fk
  end
end
