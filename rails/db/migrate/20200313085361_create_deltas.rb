class CreateDeltas < ActiveRecord::Migration[5.2]
  def change
    create_table :deltas do |t|
      t.integer :value

      t.timestamps
    end
  end
end
