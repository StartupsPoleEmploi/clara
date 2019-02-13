class CreateExplicitations < ActiveRecord::Migration[5.2]
  def change
    create_table :explicitations do |t|
      t.string :name
      t.string :slug
      t.string :operator_kind
      t.text :template
      t.timestamps
    end
  end
end
