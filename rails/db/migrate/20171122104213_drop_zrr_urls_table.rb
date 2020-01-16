class DropZrrUrlsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :zrr_urls
  end
end
