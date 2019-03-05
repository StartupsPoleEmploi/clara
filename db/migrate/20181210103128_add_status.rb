class AddStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :status, :string
  end
end
