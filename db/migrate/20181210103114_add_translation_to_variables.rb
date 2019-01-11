class AddTranslationToVariables < ActiveRecord::Migration[5.0]
  def change
    add_column :variables, :translation, :text
  end
end
