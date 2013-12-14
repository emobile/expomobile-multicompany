class CreateOfferts < ActiveRecord::Migration
  def change
    create_table :offerts do |t|
      t.references :exhibitor,                                 :null => false
      t.string :description,                                   :null => false
      t.decimal :price, :precision => 8, :scale => 2,          :null => false
      t.datetime :start_date,                                  :null => false
      t.datetime :end_date,                                    :null => false
      t.string :location,                                      :null => false
      t.references :event,                                     :null => false

      t.timestamps
    end
    add_foreign_key :offerts, :exhibitors, :name => :offerts_exhibitor_id_fk, :dependent => :delete
    add_foreign_key :offerts, :events, :name => :offerts_event_id_fk
  end
end