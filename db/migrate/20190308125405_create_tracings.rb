class CreateTracings < ActiveRecord::Migration[5.2]
  def change
    create_table :tracings do |t|
      t.text :description
      t.string :name
      t.belongs_to :rule
      t.timestamps
    end
  end
end
