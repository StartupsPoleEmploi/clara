class AddSlugToLevel3Filters < ActiveRecord::Migration[5.2]
  def change
    add_column :level3_filters, :slug, :string
    add_index :level3_filters, :slug, unique: true
  end
end
