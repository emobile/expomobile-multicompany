class CreateMailTemplates < ActiveRecord::Migration
  def change
    create_table :mail_templates do |t|
      t.string :name
      t.string :content,                           :null => false
      t.references :event,                         :null => false

      t.timestamps
    end
    add_foreign_key :mail_templates, :events, :name => :mail_templates_event_id_fk
  end
end
