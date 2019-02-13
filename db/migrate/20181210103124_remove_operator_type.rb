class RemoveOperatorType < ActiveRecord::Migration[5.2]
  def change
    remove_column :rules, :operator_type, :string
  end
end
