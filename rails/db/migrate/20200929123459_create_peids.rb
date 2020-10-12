class CreatePeids < ActiveRecord::Migration[6.0]
  def change
    create_table :peids do |t|
      t.string :value

      t.timestamps
    end 
  end    
end
