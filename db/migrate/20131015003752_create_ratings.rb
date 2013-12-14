class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value,               :null => false
      t.text :comment

      t.timestamps
    end
  end
end
