class AddAxisToNeed < ActiveRecord::Migration[5.2]
  def change
    add_reference :need_filters, :axis_filter, foreign_key: true
  end
end
