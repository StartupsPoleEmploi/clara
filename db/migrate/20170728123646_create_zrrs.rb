class CreateZrrs < ActiveRecord::Migration[5.1]
  def change
    create_table :zrrs do |t|
      t.string :value
      t.text :description

      t.timestamps
    end
  end
end
