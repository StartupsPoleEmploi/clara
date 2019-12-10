class AddAxleFilterToNeedFilter < ActiveRecord::Migration[5.2]
  def change
    add_reference :need_filters, :axle_filter, foreign_key: true
  end
end
