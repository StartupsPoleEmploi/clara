class CreateZrrsAgain < ActiveRecord::Migration[5.1]
  def change
    create_table :zrrs do |t|
      t.text :value
      t.timestamps
    end
  end
end
