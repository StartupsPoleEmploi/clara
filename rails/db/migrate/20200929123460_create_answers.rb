class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|

      t.string :handicap
      t.string :spectacle
      t.string :cadre
      t.string :diplome
      t.string :category
      t.string :duree_d_inscription
      t.string :allocation_value_min
      t.string :allocation_type
      t.string :age
      t.string :location_citycode
      t.string :location_zipcode

      t.timestamps
    end 
  end    
end
