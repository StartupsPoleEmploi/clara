class AddVariableKindToVariables < ActiveRecord::Migration[5.2]
  def change
    add_column :variables, :variable_kind, :string
  end
end
