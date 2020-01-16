class CreateJoinTableCustomFilterAid < ActiveRecord::Migration[5.2] 
  def change  
    create_join_table :custom_filters, :aids  
  end 
end
