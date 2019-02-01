class ChangeDefaultOrdreAffichageOfAid < ActiveRecord::Migration[5.1]
  def change
    change_column :aids, :ordre_affichage, :integer, :default => nil
  end
end
