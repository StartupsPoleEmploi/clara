class AddShortDescriptionToAids < ActiveRecord::Migration[5.0]
  def change
    add_column :aids, :short_description, :string
  end
end
