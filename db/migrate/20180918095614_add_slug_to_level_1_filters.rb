class AddSlugToLevel1Filters < ActiveRecord::Migration[5.1]
  def change
    add_column :level_1_filters, :slug, :string
    add_index :level_1_filters, :slug, unique: true
  end
end
