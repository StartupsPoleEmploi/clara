class CreateOffpeconnects < ActiveRecord::Migration[5.2]
  def change
    create_table :offpeconnects do |t|
      t.string :value, :default => 'off'

      t.timestamps
    end 
  end    
end
