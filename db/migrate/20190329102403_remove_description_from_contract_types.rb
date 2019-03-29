class RemoveDescriptionFromContractTypes < ActiveRecord::Migration[5.1]
  def change
    remove_column :contract_types, :description, :string
  end
end
