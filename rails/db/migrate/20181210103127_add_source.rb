class AddSource < ActiveRecord::Migration[5.2]
  def change
    add_column :aids, :source, :text
  end
end
