class AddLevel2FilterToLevel3Filter < ActiveRecord::Migration[5.2]
  def change
    add_reference :level3_filters, :level2_filter, foreign_key: true
  end
end
