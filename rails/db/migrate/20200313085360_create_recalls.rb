class CreateRecalls < ActiveRecord::Migration[5.2]
  def change
    create_table :recalls do |t|
      t.datetime "trigger_at"
      t.references :aid, foreign_key: true
      t.string :email
      t.string :status
      t.timestamps
    end
  end
end
