class AddNameTranslationToVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :name_translation, :text
  end
end
