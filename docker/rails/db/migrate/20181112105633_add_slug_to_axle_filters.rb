class AddSlugToAxleFilters < ActiveRecord::Migration[5.2]
  def change
    add_column :axle_filters, :slug, :string
    add_index :axle_filters, :slug, unique: true
  end
end
