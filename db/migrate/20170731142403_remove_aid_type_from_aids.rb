class RemoveAidTypeFromAids < ActiveRecord::Migration[5.1]
  def change
    remove_column :aids, :type, :string
  end
end
