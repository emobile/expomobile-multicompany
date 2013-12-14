class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :workshop,          :null => false
      t.references :subgroup,          :null => false
      t.references :hour,              :null => false

      t.timestamps
    end
    add_foreign_key :schedules, :workshops, :name => :schedules_workshop_id_fk
    add_foreign_key :schedules, :subgroups, :name => :schedules_subgroup_id_fk
    add_foreign_key :schedules, :hours, :name => :schedules_hour_id_fk
  end
end