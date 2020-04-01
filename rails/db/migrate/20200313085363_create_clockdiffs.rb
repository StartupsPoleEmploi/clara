class CreateClockdiffs < ActiveRecord::Migration[5.2]
  def change
    create_table :clockdiffs do |t|
      t.integer :value

      t.timestamps
    end
  end
end
