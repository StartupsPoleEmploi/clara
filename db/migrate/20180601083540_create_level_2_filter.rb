class CreateLevel1Filters < ActiveRecord::Migration[5.1]
  def change
    create_table :level_1_filters do |t|
      t.text :name, unique: true
    end
  end
end
