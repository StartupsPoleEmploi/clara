class CallbackAsker < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @asker = locals[:asker].attributes.with_indifferent_access
    @meta = hash_for(locals[:meta])
  end

  def prenom
    @meta[:given_name]
  end

  def inscription
    case @asker[:v_inscrit]
    when 'oui'
      "Inscrit à Pôle Emploi"
    when 'en_recherche'
      "En recherche d'emploi sans y être inscrit"
    else
      "indisponible"
    end
  end

  def age
    @asker[:v_age]
  end

  def diplome
    ResultSituation.new(nil, nil).diplome(@asker)
  end

  def location_label
    @asker[:v_location_label]
  end

  def allocation_type
    res = nil
    temp = ResultSituation.new(nil, nil).allocation_type(@asker)
    if temp != 'indisponible'
      res = temp
    end
    res
  end


end
