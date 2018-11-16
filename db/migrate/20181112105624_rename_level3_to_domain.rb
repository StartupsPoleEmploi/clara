class RenameLevel3ToDomain < ActiveRecord::Migration[5.2] 
  def change  
    rename_table :level3_filters, :domain_filters 
  end 
end
