class CreateJoinTableLevel3FilterAid < ActiveRecord::Migration[5.2]
  def change
    create_join_table :level3_filters, :aids do |t|
      # t.index [:level3_filter_id, :aid_id]
      # t.index [:aid_id, :level3_filter_id]
    end
  end
end
