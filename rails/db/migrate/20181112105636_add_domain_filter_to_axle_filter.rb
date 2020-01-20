class AddDomainFilterToAxleFilter < ActiveRecord::Migration[5.2]
  def change
    add_reference :axle_filters, :domain_filter, foreign_key: true
  end
end
