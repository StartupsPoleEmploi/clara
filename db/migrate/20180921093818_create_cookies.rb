class CreateCookies < ActiveRecord::Migration[5.2]
  def change
    create_table :cookies do |t|
      t.boolean :statistic
      t.boolean :navigation

      t.timestamps
    end
  end
end
