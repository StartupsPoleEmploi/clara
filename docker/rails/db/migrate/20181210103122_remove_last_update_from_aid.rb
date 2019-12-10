class RemoveLastUpdateFromAid < ActiveRecord::Migration[5.2]
  def change
    remove_column :aids, :last_update, :text
  end
end
