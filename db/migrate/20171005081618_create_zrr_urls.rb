class CreateZrrUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :zrr_urls do |t|
      t.text :value

      t.timestamps
    end
  end
end
