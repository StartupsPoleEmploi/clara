class CreateRegister < ActiveRecord::Migration[5.2]
  def change
    create_table :registers do |t|
      t.string :url
      t.string :geo
      t.string :moment
      t.string :user
      t.timestamps
    end
  end
end
