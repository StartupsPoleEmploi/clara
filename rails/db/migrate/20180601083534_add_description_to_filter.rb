class AddDescriptionToFilter < ActiveRecord::Migration[5.1]
  def change
    add_column :filters, :description, :string
  end
end
