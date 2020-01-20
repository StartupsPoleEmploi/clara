class AddSlugToFilters < ActiveRecord::Migration[5.1]
  def change
    add_column :filters, :slug, :string
    add_index :filters, :slug, unique: true
  end
end
