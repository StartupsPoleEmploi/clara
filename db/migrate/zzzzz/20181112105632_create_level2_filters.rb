class CreateLevel2Filters < ActiveRecord::Migration[5.2]
  def change
    create_table :level2_filters do |t|
      t.string :name, unique: true
      t.text :description
      t.timestamps
    end
  end
end
