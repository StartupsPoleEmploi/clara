class RenameLevel2ToAxis < ActiveRecord::Migration[5.2] 
  def change  
    rename_table :level2_filters, :axis_filters 
  end 
end
