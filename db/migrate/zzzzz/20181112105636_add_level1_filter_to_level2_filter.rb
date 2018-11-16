class AddLevel1FilterToLevel2Filter < ActiveRecord::Migration[5.2]
  def change
    add_reference :level2_filters, :level1_filter, foreign_key: true
  end
end
