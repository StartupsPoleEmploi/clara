class AddSlugToContractTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :contract_types, :slug, :string
    add_index :contract_types, :slug, unique: true
  end
end
