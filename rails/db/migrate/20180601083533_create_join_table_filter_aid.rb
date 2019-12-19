class CreateJoinTableFilterAid < ActiveRecord::Migration[5.1]
  def change
    create_join_table :filters, :aids do |t|
      # t.index [:filter_id, :aid_id]
      # t.index [:aid_id, :filter_id]
    end
  end
end
