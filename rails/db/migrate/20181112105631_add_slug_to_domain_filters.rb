class AddSlugToDomainFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :domain_filters, :slug, :string
    add_index :domain_filters, :slug, unique: true
  end
end
