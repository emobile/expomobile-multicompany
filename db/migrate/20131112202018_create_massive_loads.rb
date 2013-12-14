class CreateMassiveLoads < ActiveRecord::Migration
  def change
    create_table :massive_loads do |t|

      t.timestamps
    end
  end
end
