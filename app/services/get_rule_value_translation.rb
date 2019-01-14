class GetRuleValueTranslation < ClaraService
  initialize_with_keywords :variable_id, :key_value
  is_callable


  def call
    v = Variable.find(@variable_id)
    translations = v.elements_translation.split(",")
    keys = v.elements.split(",")
    index_of_key = keys.find_index(@key_value)
    translations[index_of_key]
  end

end
