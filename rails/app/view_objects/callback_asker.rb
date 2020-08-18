class CallbackAsker < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @asker = locals[:asker].attributes.with_indifferent_access
    @meta = locals[:meta].with_indifferent_access
  end

  def prenom
    StringUtils.new.upcase_first_downcase_others(@meta[:given_name])
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

  def duree_d_inscription
    res = nil
    temp = ResultSituation.new(nil, nil).duree_d_inscription(@asker)
    if temp != 'indisponible' && temp != 'non inscrit'
      res = temp
    end
    res
  end

  def categorie
    res = nil
    temp = ResultSituation.new(nil, nil).category(@asker)
    if temp != 'indisponible'
      res = temp
    end
    res
  end

  def allocation_type
    res = nil
    temp = ResultSituation.new(nil, nil).allocation_type(@asker)
    if temp != 'indisponible'
      res = temp
    end
    res
  end

  def allocation_montant
    @asker[:v_allocation_value_min].to_s
  end


end
