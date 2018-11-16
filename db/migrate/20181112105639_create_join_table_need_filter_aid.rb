class CreateJoinTableNeedFilterAid < ActiveRecord::Migration[5.2]
  def change
    create_join_table :need_filters, :aids do |t|
      # t.index [:need_filter_id, :aid_id]
      # t.index [:aid_id, :need_filter_id]
    end
  end
end
