class AddSlugToCustomFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :custom_filters, :slug, :string
    add_index :custom_filters, :slug, unique: true
  end
end
