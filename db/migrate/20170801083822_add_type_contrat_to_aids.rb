class AddTypeContratToAids < ActiveRecord::Migration[5.1]
  def change
    add_column :aids, :type_contrat, :integer, :default => 0
  end
end
