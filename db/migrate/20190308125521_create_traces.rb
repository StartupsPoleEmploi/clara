class CreateTraces < ActiveRecord::Migration[5.2]
  def change
    create_table :traces do |t|
      t.string :url
      t.string :geo
      t.string :user
      t.belongs_to :tracing
      t.timestamps
    end
  end
end
