class ChangeDefaultOrdreAffichageOfCt < ActiveRecord::Migration[5.1]
  def change
    change_column :contract_types, :ordre_affichage, :integer, :default => nil
  end
end
