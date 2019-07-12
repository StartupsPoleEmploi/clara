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

  def title_of_tab
    case @contract[:slug]
    when 'aide-a-la-creation-ou-reprise-d-entreprise'
      'Aides à la création ou reprise d\'entreprise'
    when 'aide-a-la-mobilite'
      'Aides à la mobilité, au déplacement, garde d\'enfant'
    when 'contrat-en-alternance' 
      'Aides à l\'alternance'
    when 'aide-a-la-definition-du-projet-professionnel'   
      'Aides à l\'orientation, la reconversion professionnelle'
    else
      "#{@contract[:name]}"
    end
  end


end
