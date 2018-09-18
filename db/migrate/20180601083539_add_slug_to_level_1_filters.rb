class AddSlugToLevel1Filters < ActiveRecord::Migration[5.1]
  def change
    add_column :level_1_filters, :slug, :string, null: false
    add_index :level_1_filters, :slug, unique: true
  end
end
