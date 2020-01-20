class RemoveIconFromAid < ActiveRecord::Migration[5.1]
  def change
    remove_column :aids, :icon
  end
end
