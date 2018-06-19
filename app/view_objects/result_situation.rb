class ResultSituation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    p '- - - - - - - - - - - - - - locals- - - - - - - - - - - - - - - -' 
    pp locals
    p ''
    @asker = hash_for(locals[:asker])
  end

  def handicap
    @asker[:v_handicap] || "indisponible"
  end

  def spectacle
    @asker[:v_spectacle] || "indisponible"
  end

  def diplome
    case @asker[:v_diplome]
    when 'niveau_1'
      "Bac +4 et +"
    when 'niveau_2'
      "Bac +3"
    when 'niveau_3'
      "Bac +1 à +2"
    when 'niveau_4'
      "Bac"
    when 'niveau_5'
      "CAP BEP"
    when 'niveau_infra_5'
      "aucun"
    else
      "indisponible"
    end
  end
 
  def category
    case @asker[:v_category]
    when 'cat_12345'
      "12345"
    when 'autres_cat'
      "hors 12345"
    else
      "indisponible"
    end
  end
  
  def duree_d_inscription
    case @asker[:v_duree_d_inscription]
    when 'moins_d_un_an'
      "moins d'un an"
    when 'plus_d_un_an'
      "plus d'un an"
    when 'non_inscrit'
      "non inscrit"
    else
      "indisponible"
    end
  end
 
  def allocation_value_min
    @asker[:v_allocation_value_min] || "indisponible"
  end
  
  def allocation_type
    case @asker[:v_allocation_type]
    when 'ARE_ASP'
      "ARE ASP"
    when 'ASS_AER_ATA_APS_AS-FNE'
      "ASS AER ATA APS AS-FNE"
    when 'RPS_RFPA_RFF_pensionretraite'
      "RPS RFPA RFF ou pension de retraite"
    when 'RSA'
      "RSA"
    when 'AAH'
      "AAH"
    when 'pas_indemnise'
      "aucune"
    else
      "indisponible"
    end
  end
  
  def location_label
    @asker[:v_location_label].blank? ? "indisponible" : @asker[:v_location_label]
  end
  
  def qpv
    case @asker[:v_qpv]
    when 'en_qpv'
      "oui"
    when 'hors_qpv'
      "non"
    else
      "<a target='blank' href='https://sig.ville.gouv.fr/adresses/recherche'>vérifier</a>"
    end
  end

  def zrr
    case @asker[:v_zrr]
    when 'en_zrr'
      "oui"
    when 'hors_zrr'
      "non"
    else
      "indisponible"
    end
  end  
  
  def age
    @asker[:v_age] || "indisponible"
  end

end
