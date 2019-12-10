class CreateTracings < ActiveRecord::Migration[5.2]
  def change
    create_table :tracings do |t|
      t.text :description
      t.string :name
      t.boolean :all_aids
      t.belongs_to :rule
      t.timestamps
    end
  end
end
