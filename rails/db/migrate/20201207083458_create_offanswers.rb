class CreateOffanswers < ActiveRecord::Migration[6.0]
  def change
    create_table :offanswers do |t|
      t.string :value, :default => 'off'

      t.timestamps
    end 
  end    
end
