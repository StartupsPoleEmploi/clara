class GetRuleValueTranslation < ClaraService
  initialize_with_keywords :variable_id, :key_value
  is_callable

  def call
    p '- - - - - - - - - - - - - - variable_id- - - - - - - - - - - - - - - -' 
    pp variable_id
    p ''
    p '- - - - - - - - - - - - - - key_value- - - - - - - - - - - - - - - -' 
    pp key_value
    p ''
    v = Variable.find(@variable_id)
    p '- - - - - - - - - - - - - - v- - - - - - - - - - - - - - - -' 
    pp v
    p ''
    translations = v.elements_translation.split(",")
    p '- - - - - - - - - - - - - - translations- - - - - - - - - - - - - - - -' 
    pp translations
    p ''
    keys = v.elements.split(",")
    p '- - - - - - - - - - - - - - keys- - - - - - - - - - - - - - - -' 
    pp keys
    p ''
    index_of_key = keys.find_index(@key_value)
    p '- - - - - - - - - - - - - - index_of_key- - - - - - - - - - - - - - - -' 
    pp index_of_key
    p ''
    p '- - - - - - - - - - - - - - translations- - - - - - - - - - - - - - - -' 
    pp translations[index_of_key]
    p ''
    translations[index_of_key]
  end

end
