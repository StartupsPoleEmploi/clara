class AddCategoryToContractType < ActiveRecord::Migration[5.1]
  def change
    add_column :contract_types, :category, :string
  end
end
