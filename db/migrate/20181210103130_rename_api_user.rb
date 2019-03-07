class RenameApiUser < ActiveRecord::Migration[5.2]
 def change
   rename_table :users, :api_users
 end 
end
