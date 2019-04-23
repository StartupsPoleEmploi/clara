class TypeExplanation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @number_of_aids = integer_for(locals[:number_of_aids])
    @slug = string_for(locals[:slug])
    @name = string_for(locals[:name])
  end

  def has_text
    return full_text != "" && @number_of_aids > 0
  end

  def number_of_aids
    @number_of_aids
  end

  def full_text
    "<div>Vous pouvez vérifier votre éligibilité à <span class='aid-nb-txt'><strong>#{number_of_aids} aides</strong> pour :<strong> #{@name.downcase}.</strong></span></div>".html_safe
  end

end
