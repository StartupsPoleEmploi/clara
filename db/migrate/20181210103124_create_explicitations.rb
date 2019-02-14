class CreateExplicitations < ActiveRecord::Migration[5.2]
  def change
    create_table :explicitations do |t|
      t.string :name
      t.string :slug
      t.text :template
      t.references :variable, foreign_key: true
      t.string :operator_kind
      t.string :value_eligible
      t.timestamps
    end
  end
end
