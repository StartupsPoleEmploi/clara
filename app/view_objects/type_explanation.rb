class TypeExplanation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @number_of_aids = integer_for(locals[:number_of_aids])
    @slug = string_for(locals[:slug])
    @contract = hash_for(locals[:contract])
  end

  def has_text
    return full_text != "" && @number_of_aids > 0
  end

  def number_of_aids
    @number_of_aids
  end

  def title_of_tab
    "#{@contract[:name]}"
  end

  def full_text
    case @slug
    when "aide-a-la-creation-ou-reprise-d-entreprise"
      "<div>Vous pouvez vérifier votre éligibilité à <strong><span class='aid-nb-txt'>#{number_of_aids} aides</span> à la création ou reprise d'entreprise.</strong></div>".html_safe
    when "aide-a-la-mobilite"
      "<div>Vous pouvez vérifier votre éligibilité à <strong><span class='aid-nb-txt'>#{number_of_aids} aides</span> à la mobilité.</strong></div>".html_safe
    when "contrat-en-alternance"
      "<div>Vous pouvez vérifier votre éligibilité à <strong><span class='aid-nb-txt'>#{number_of_aids} aides</span> à l'alternance.</strong></div>".html_safe
    when "aide-a-la-definition-du-projet-professionnel"
      "<div>Vous pouvez vérifier votre éligibilité à <strong><span class='aid-nb-txt'>#{number_of_aids} aides</span> à la définition du projet professionnel.</strong></div>".html_safe
    else 
      ""
    end
  end

end
