class AddHourminToRecall < ActiveRecord::Migration[6.0]
  def change
    add_column :recalls, :hourmin, :string
  end  
end
