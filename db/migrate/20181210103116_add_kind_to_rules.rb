class AddKindToRules < ActiveRecord::Migration[5.0]
  def change
    add_column :rules, :kind, :string
  end
end
