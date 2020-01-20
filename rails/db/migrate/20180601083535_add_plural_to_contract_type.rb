class AddPluralToContractType < ActiveRecord::Migration[5.1]
  def change
    add_column :contract_types, :plural, :string
  end
end
