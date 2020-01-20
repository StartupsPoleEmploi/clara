class AddOrdreAffichageToFilters < ActiveRecord::Migration[5.1]
  def change
    add_column :filters, :ordre_affichage, :integer, :default => nil
  end
end
