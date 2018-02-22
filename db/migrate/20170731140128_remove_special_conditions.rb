class RemoveSpecialConditions < ActiveRecord::Migration[5.1]
  def change
    drop_table :special_conditions
    drop_table :locations
  end
end
