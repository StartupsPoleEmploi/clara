class TypeShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @aids = array_for(locals[:aids])
  end

  def contract_type
    @contract
  end

  def clazz
    "c-detail-title--#{@contract[:slug]}"
  end

  def has_line
    @aids.size > 0
  end

  def line
    FilterRawAidsService.new(@aids).go[0]
  end

  def title
    "#{@contract[:name]}"
  end

  def other_title_tab
    if @contract[:slug] != "aide-a-la-creation-ou-reprise-d-entreprise" && @contract[:slug] != "contrat-en-alternance" && @contract[:slug] != "aide-a-la-definition-du-projet-professionnel" && @contract[:slug] != "aide-a-la-mobilite" && !@contract[:name].blank?
      "#{@contract[:name]}"
    else
      ""
    end
  end

  def title_of_tab
    case @contract[:slug]
    when "aide-a-la-creation-ou-reprise-d-entreprise"
      "à la création ou reprise d'entreprise"
    when "aide-a-la-mobilite"
      "à la mobilité, au déplacement, garde d'enfant"
    when "contrat-en-alternance"
      "à l'alternance"
    when "aide-a-la-definition-du-projet-professionnel"    
      "à l'orientation, la reconversion professionnelle"
    else
      other_title_tab
    end
  end


end
