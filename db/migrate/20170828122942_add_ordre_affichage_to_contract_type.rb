class AddOrdreAffichageToContractType < ActiveRecord::Migration[5.1]
  def change
    add_column :contract_types, :ordre_affichage, :integer, :default => 0
  end
end
