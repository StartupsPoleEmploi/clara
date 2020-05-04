class TypeShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @aids = array_for(locals[:aids])
    _hacky_addition_for_ddct(@aids)
  end

  def _hacky_addition_for_ddct(aids)
    if @context
      slug_of_contract = @context.params[:id]
      if slug_of_contract == "financement-aide-a-la-formation"
        # Remboursement des frais kilométriques
        aids << ActivatedModelsService.instance.aids.detect{|aid| aid["slug"] == "aide-a-la-mobilite-frais-de-deplacement"} 
        # Frais d'hébergement
        aids << ActivatedModelsService.instance.aids.detect{|aid| aid["slug"] == "aide-a-la-mobilite-frais-d-hebergement"} 
        # Frais de repas
        aids << ActivatedModelsService.instance.aids.detect{|aid| aid["slug"] == "aide-a-la-mobilite-frais-de-repas"} 
        # Aide à la garde d'enfant pour les parents isolés (AGEPI)
        aids << ActivatedModelsService.instance.aids.detect{|aid| aid["slug"] == "agepi"} 
      end
    end
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
