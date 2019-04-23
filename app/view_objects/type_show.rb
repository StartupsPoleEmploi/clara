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

  def aid_cre
    @aid_cre = "aide-a-la-creation-ou-reprise-d-entreprise"
  end

  def aid_al
    @aid_al = "contrat-en-alternance" 
  end

  def aid_dpp
    @aid_dpp = "aide-a-la-definition-du-projet-professionnel"
  end

  def aid_mob
    @aid_mob = "aide-a-la-mobilite"
  end

  def other_title_tab
    slugs = [aid_cre, aid_al, aid_dpp, aid_mob]
    if !slugs.include?(@contract[:slug]) && !@contract[:name].blank?
      "#{@contract[:name]}"
    else
      ""
    end
  end

  def title_of_tab
    case @contract[:slug]
    when aid_cre
      "à la création ou reprise d'entreprise"
    when aid_mob
      "à la mobilité, au déplacement, garde d'enfant"
    when aid_al
      "à l'alternance"
    when aid_dpp    
      "à l'orientation, la reconversion professionnelle"
    else
      other_title_tab
    end
  end


end
