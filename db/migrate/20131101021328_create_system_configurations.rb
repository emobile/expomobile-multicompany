class CreateSystemConfigurations < ActiveRecord::Migration
  def change
    create_table :system_configurations do |t|
      t.string :token,                             :null => false
      t.string :language,                          :null => false

      t.timestamps
    end
  end
end