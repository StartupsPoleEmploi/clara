class AddOrdreAffichageToAids < ActiveRecord::Migration[5.1]
  def change
    add_column :aids, :ordre_affichage, :integer, :default => 0
  end
end
