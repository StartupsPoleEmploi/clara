class CreateBrokens < ActiveRecord::Migration[5.2]
  def change
    create_table :brokens do |t|
      t.string :url
      t.integer :code
      t.string :new_url
      t.text :aids_slug

      t.timestamps
    end 
  end    
end
