class AddIconToAids < ActiveRecord::Migration[5.0]
  def change
    add_column :aids, :icon, :string
  end
end
