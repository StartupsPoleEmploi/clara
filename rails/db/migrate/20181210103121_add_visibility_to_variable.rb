class AddVisibilityToVariable < ActiveRecord::Migration[5.2]
  def change
    add_column :variables, :is_visible, :boolean, default: true
  end
end
