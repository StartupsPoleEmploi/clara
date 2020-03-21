class AddIconToFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :filters, :icon, :text
  end   
end
