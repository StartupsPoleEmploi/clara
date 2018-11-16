class RenameLevel1ToDomain < ActiveRecord::Migration[5.2] 
  def change  
    rename_table :level1_filters, :domain_filters 
  end 
end
