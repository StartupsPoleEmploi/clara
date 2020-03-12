class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.string :positive
      t.string :url_of_detail
      t.timestamps
    end  
  end    
end
