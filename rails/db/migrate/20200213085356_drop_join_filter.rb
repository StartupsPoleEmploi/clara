class DropJoinFilter < ActiveRecord::Migration[5.2]
  def up
    drop_join_table :aids, :custom_filters
    drop_join_table :aids, :need_filters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
