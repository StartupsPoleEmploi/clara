class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_column :filters, :icon, :string
  end   
end
