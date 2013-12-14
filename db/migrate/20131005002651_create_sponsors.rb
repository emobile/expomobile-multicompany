class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name,                                  :null => false
      t.string :contact,                               :null => false
      t.string :social_reason,                         :null => false
      t.string :phone,                                 :null => false
      t.string :email,                                 :null => false
      t.string :job
      t.string :work_street
      t.string :work_street_number
      t.string :work_colony
      t.integer :work_zip
      t.string :web_page
      t.string :twitter
      t.references :event,                             :null => false

      t.timestamps
    end
    add_foreign_key :sponsors, :events, :name => :sponsors_event_id_fk
  end
end