class CreateTracizations < ActiveRecord::Migration[5.2]
  def change
    create_table :tracizations do |t|
      t.belongs_to :monitor, index: true
      t.belongs_to :aid, index: true
      t.text :description
      t.timestamps
    end
  end
end
