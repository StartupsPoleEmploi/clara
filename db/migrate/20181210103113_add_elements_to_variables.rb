class AddElementsToVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :elements, :text
  end
end
