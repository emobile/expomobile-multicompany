class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name,                          :null => false
      t.boolean :is_admin,                     :null => false, :default => false
      t.boolean :is_super_admin,               :null => false, :default => false

      t.timestamps
    end
  end
end