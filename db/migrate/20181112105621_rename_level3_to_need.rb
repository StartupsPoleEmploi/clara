class RenameLevel3ToNeed < ActiveRecord::Migration[5.2] 
  def change  
    rename_table :level3_filters, :need_filters 
  end 
end
