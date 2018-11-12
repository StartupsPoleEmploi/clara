class AddSlugToCustomParentFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :custom_parent_filters, :slug, :string
    add_index :custom_parent_filters, :slug, unique: true
  end
end
