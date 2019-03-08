class CreateMonitors < ActiveRecord::Migration[5.2]
  def change
    create_table :monitors do |t|
      t.string :name
      t.belongs_to :rule
      t.text :description
      t.timestamps
    end
  end
end
