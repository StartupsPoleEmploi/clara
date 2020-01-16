class AddSimulatedToRules < ActiveRecord::Migration[5.2]
  def change
    rename_column :rules, :status, :simulated
  end
end
