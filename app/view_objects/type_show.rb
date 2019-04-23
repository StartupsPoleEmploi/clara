class TypeShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @aids = array_for(locals[:aids])
    @aid_al = "contrat-en-alternance" 
    @aid_dpp = "aide-a-la-definition-du-projet-professionnel"
    @aid_cre = "aide-a-la-creation-ou-reprise-d-entreprise"
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

  def title_of_tab
    case @contract[:slug]
    when @aid_cre
      "Aides à la création ou reprise d'entreprise"
    when @aid_mob
      "Aides à la mobilité, au déplacement, garde d'enfant"
    when @aid_al
      "Aides à l'alternance"
    when @aid_dpp    
      "Aides à l'orientation, la reconversion professionnelle"
    else
      "#{@contract[:name]}"
    end
  end


end
