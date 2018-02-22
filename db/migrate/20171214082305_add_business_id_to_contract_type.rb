class AddBusinessIdToContractType < ActiveRecord::Migration[5.1]
  def change
    add_column :contract_types, :business_id, :string
    add_index :contract_types, :business_id, unique: true
  end
end
