class RemoveLeveledFilters < ActiveRecord::Migration[5.2] 
  def change
    remove_reference :level2_filters, :level1_filter, foreign_key: true
    remove_reference :level3_filters, :level2_filter, foreign_key: true
    drop_join_table :level3_filters, :aids
    drop_table :level3_filters
    drop_table :level2_filters
    drop_table :level1_filters
  end 
end
