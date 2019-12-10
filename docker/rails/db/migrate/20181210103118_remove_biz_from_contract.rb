class RemoveBizFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contract_types, :business_id, :string
  end
end
