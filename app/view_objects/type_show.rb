class TypeShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @aids = array_for(locals[:aids])
  end

  def slugs
    @aid_cre = "aide-a-la-creation-ou-reprise-d-entreprise"
    @aid_al = "contrat-en-alternance" 
    @aid_dpp = "aide-a-la-definition-du-projet-professionnel"
    @aid_mob = "aide-a-la-mobilite"
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
    if @contract[:slug] != @aid_cre && @contract[:slug] != @aid_al && @contract[:slug] != @aid_dpp && @contract[:slug] != @aid_mob && !@contract[:name].blank?
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
