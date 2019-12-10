class AddIconToContractTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :contract_types, :icon, :string
  end
end
