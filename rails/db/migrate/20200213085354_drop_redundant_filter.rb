class DropRedundantFilter < ActiveRecord::Migration[5.2]
  def up
    drop_table :need_filters
    drop_table :axle_filters
    drop_table :domain_filters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
