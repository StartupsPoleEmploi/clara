class DropZrrsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :zrrs
  end
end
