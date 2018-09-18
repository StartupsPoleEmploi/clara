class AddSlugToLevel1Filters < ActiveRecord::Migration[5.2]
  def change
    add_column :level1_filters, :slug, :string
    add_index :level1_filters, :slug, unique: true
  end
end
