class AddAttachmentLogoToExhibitor < ActiveRecord::Migration
  def self.up
    add_column :exhibitors, :logo_file_name, :string
    add_column :exhibitors, :logo_content_type, :string
    add_column :exhibitors, :logo_file_size, :integer
    add_column :exhibitors, :logo_updated_at, :datetime
  end

  def self.down
    remove_column :exhibitors, :logo_file_name
    remove_column :exhibitors, :logo_content_type
    remove_column :exhibitors, :logo_file_size
    remove_column :exhibitors, :logo_updated_at
  end
end
