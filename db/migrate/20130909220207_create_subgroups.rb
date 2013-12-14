class CreateSubgroups < ActiveRecord::Migration
  def change
    create_table :subgroups do |t|
      t.string :name,                  :null => false
      t.string :leader,                :null => false
      t.string :subgroup_key,          :null => false
      t.references :group,             :null => false
      t.references :event,             :null => false

      t.timestamps
    end
    add_foreign_key :subgroups, :groups, :name => :subgroups_group_id_fk
    add_foreign_key :subgroups, :events, :name => :subgroups_event_id_fk
  end
end
