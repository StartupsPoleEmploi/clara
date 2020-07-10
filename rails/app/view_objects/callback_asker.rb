class CallbackAsker < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @asker = locals[:asker].attributes.with_indifferent_access
    p '- - - - - - - - - - - - - - parse- - - - - - - - - - - - - - - -' 
    pp locals[:meta]
    p ''
    @meta = locals[:meta].with_indifferent_access


  end

  def prenom
    _upcase_first_letter(@meta[:given_name])
  end

  def _upcase_first_letter(str)
    local_str = str.downcase
    final_str = local_str[0].upcase + local_str[1..-1]
    final_str
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
    res = ''
    res = "plus d'un an" if @asker[:v_duree_d_inscription] == 'plus_d_un_an'
    res = "moins d'un an" if @asker[:v_duree_d_inscription] == 'moins_d_un_an'
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


end
