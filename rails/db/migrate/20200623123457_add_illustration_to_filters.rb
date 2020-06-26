class AddIllustrationToFilters < ActiveRecord::Migration[5.2]
  def change
    add_attachment :filters, :illustration
  end
end
