class AddSlugToAids < ActiveRecord::Migration[5.0]
  def change
    add_column :aids, :slug, :string
    add_index :aids, :slug, unique: true
  end
end
