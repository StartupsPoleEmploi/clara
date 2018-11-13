class CreateJoinTableCustomParentFilterAid < ActiveRecord::Migration[5.2]
  def change
    create_join_table :custom_parent_filters, :aids
  end
end
