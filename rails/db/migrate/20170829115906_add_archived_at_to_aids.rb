class AddArchivedAtToAids < ActiveRecord::Migration[5.1]
  def change
    add_column :aids, :archived_at, :datetime
  end
end
