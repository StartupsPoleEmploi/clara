class AddGaPeToStats < ActiveRecord::Migration[5.1]
  def change
    add_column :stats, :ga_pe, :jsonb, :default => '{}'
  end
end
