class AddAuthorHiddenToFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :filters, :is_hidden, :boolean, default: false
    add_column :filters, :author, :string
  end
end
