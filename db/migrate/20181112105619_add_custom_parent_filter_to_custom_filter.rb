class AddCustomParentFilterToCustomFilter < ActiveRecord::Migration[5.2]
  def change
    add_reference :custom_filters, :custom_parent_filter, foreign_key: true
  end
end
