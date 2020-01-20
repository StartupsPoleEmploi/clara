class CreateContractTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :contract_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
