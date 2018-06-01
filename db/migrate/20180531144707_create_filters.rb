class CreateFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :filters do |t|
      t.text :name, unique: true

      t.timestamps
    end
  end
end
