class AddDescriptionToRule < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :description, :text
  end
end
