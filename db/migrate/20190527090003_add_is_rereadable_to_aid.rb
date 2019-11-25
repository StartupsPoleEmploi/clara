class AddIsRereadableToAid < ActiveRecord::Migration[5.1]
  def change 
    add_column :aids, :is_rereadable, :boolean, default: false
  end
end
