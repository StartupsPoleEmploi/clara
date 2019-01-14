class GetRuleValueTranslation < ClaraService
  initialize_with_keywords :variable_id, :key_value
  is_callable

  def call
    result = @key_value.to_s
    v = Variable.find_by(id: @variable_id)
    p '- - - - - - - - - - - - - - @key_value- - - - - - - - - - - - - - - -' 
    pp @key_value
    p ''
    p '- - - - - - - - - - - - - - @variable_id- - - - - - - - - - - - - - - -' 
    pp @variable_id
    p ''
    if v
      if !v.elements_translation.blank?
        translations = v.elements_translation.split(",")
        keys = v.elements.split(",")
        index_of_key = keys.find_index(@key_value)
        result = translations[index_of_key]
      end
    end
    result
  end

end
