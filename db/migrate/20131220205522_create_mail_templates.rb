class CreateMailTemplates < ActiveRecord::Migration
  def change
    create_table :mail_templates do |t|
      t.string :name
      t.string :content,                           :null => false

      t.timestamps
    end
  end
end
