class RemovePaperclipArtifacts < ActiveRecord::Migration[6.0]

  def change
    remove_column :filters, :illustration_file_name 
    remove_column :filters, :illustration_content_type 
    remove_column :filters, :illustration_file_size 
    remove_column :filters, :illustration_updated_at 
  end
  
end
