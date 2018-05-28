class AddHjAdToStats < ActiveRecord::Migration[5.1]
  def change
    add_column :stats, :hj_ad, :jsonb, :default => '{}'
  end
end
