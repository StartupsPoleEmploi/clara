class AddConfidentialityToNeedFilter < ActiveRecord::Migration[5.2]
  def change
    add_column :need_filters, :confidentiality, :boolean, default: true
  end
end
