class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|

      t.string :v_handicap
      t.string :v_spectacle
      t.string :v_cadre
      t.string :v_diplome
      t.string :v_category
      t.string :v_duree_d_inscription
      t.string :v_allocation_value_min
      t.string :v_allocation_type
      t.string :v_age
      t.string :v_location_citycode
      t.string :v_location_zipcode

      t.timestamps
    end 
  end    
end
