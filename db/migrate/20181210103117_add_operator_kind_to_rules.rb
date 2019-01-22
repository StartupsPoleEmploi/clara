class AddOperatorKindToRules < ActiveRecord::Migration[5.0]
  def change
    add_column :rules, :operator_kind, :string
  end
end
