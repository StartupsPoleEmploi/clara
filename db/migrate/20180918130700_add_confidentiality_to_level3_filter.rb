class AddConfidentialityToLevel3Filter < ActiveRecord::Migration[5.2]
  def change
    add_column :level3_filters, :confidentiality, :boolean, default: true
  end
end
