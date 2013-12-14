class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name,          :null => false
      t.references :event,     :null => false

      t.timestamps
    end
    add_foreign_key :groups, :events, :name => :groups_event_id_fk
  end
end