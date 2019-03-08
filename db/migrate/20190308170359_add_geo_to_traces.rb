class AddGeoToTraces < ActiveRecord::Migration[5.2]
  def change
    add_column :traces, :geo, :string

  end
end
