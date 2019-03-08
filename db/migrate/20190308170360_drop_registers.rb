class DropRegisters < ActiveRecord::Migration[5.2]
  def change
    drop_table :registers
  end
end
