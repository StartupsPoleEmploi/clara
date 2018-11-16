class AddDomainToAxis < ActiveRecord::Migration[5.2]
  def change
    add_reference :axis_filters, :domain_filter, foreign_key: true
  end
end
