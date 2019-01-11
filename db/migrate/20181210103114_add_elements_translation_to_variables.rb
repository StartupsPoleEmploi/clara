class AddElementsTranslationToVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :elements_translation, :text
  end
end
