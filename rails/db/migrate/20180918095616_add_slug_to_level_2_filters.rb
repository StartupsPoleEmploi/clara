class AddSlugToLevel2Filters < ActiveRecord::Migration[5.2]
  def change
    add_column :level2_filters, :slug, :string
    add_index :level2_filters, :slug, unique: true
  end
end
