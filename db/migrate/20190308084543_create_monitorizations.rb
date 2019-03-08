class CreateMonitorizations < ActiveRecord::Migration[5.2]
  def change
    # See https://guides.rubyonrails.org/association_basics.html#the-has-many-through-association
    create_table :monitorizations do |t|
      t.belongs_to :monitor, index: true
      t.belongs_to :aid, index: true
      t.text :description
      t.timestamps
    end
  end
end
