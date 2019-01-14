class GetRuleValueTranslation < ClaraService
  initialize_with_keywords :variable_id, :key_value
  is_callable

  def call
    result = @key_value.to_s
    v = Variable.find_by(id: @variable_id)
    if v && !v.elements_translation.blank?
      translations = v.elements_translation.split(",")
      keys = v.elements.split(",")
      index_of_key = keys.find_index(@key_value)
      result = translations[index_of_key]
    end
    result
  end

end
