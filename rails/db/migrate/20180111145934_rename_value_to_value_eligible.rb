class RenameValueToValueEligible < ActiveRecord::Migration[5.1]
  def change
    rename_column :rules, :value, :value_eligible
    add_column :rules, :value_ineligible, :string
    remove_column :rules, :value_type
  end
end
