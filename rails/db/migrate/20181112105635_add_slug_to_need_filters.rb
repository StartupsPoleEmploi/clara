class AddSlugToNeedFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :need_filters, :slug, :string
    add_index :need_filters, :slug, unique: true
  end
end
