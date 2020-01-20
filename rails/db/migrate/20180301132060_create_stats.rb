class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.jsonb :ga, default: '{}'
      t.timestamps
    end
  end
end
