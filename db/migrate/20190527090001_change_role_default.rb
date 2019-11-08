class ChangeRoleDefault < ActiveRecord::Migration[5.1]
  def change 
    change_column_default :users, :role, from: "admin", to: "contributeur" 
  end
end
