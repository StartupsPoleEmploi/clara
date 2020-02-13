class DropCustomFilter < ActiveRecord::Migration[5.2]
  def up
    drop_table :custom_filters
    drop_table :custom_parent_filters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
