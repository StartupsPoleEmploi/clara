class AddLastUpdateToAids < ActiveRecord::Migration[5.1]
  def change
    add_column :aids, :last_update, :text
  end
end
