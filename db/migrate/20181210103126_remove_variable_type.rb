class RemoveVariableType < ActiveRecord::Migration[5.2]
  def change
    remove_column :variables, :variable_type, :integer
  end
end
