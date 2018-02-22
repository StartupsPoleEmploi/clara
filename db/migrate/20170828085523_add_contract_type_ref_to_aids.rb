class AddContractTypeRefToAids < ActiveRecord::Migration[5.1]
  def change
    add_reference :aids, :contract_type, foreign_key: true
  end
end
