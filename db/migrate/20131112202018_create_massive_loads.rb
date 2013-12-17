class CreateMassiveLoads < ActiveRecord::Migration
  def change
    create_table :massive_loads do |t|
      t.references :event,                          :null => false

      t.timestamps
    end
    add_foreign_key :massive_loads, :events, :name => :massive_loads_event_id_fk
  end
end
