class RemoveTypeContratFromAid < ActiveRecord::Migration[5.1]
  def change
    remove_column :aids, :type_contrat
  end
end
