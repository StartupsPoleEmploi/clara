class AddMoreDescriptionsToAids < ActiveRecord::Migration[5.1]
  def change
    rename_column :aids, :description, :what
    add_column :aids, :how_much, :text
    add_column :aids, :additionnal_conditions, :text
    add_column :aids, :how_and_when, :text
    add_column :aids, :limitations, :text
  end
end
