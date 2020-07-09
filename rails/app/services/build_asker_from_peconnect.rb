class BuildAskerFromPeconnect
  
  def call(peconnect_data)
    asker = Asker.new
    asker.v_age = _actual_age(peconnect_data.try(:[], :birth).try(:[], "dateDeNaissance"))
    asker.v_location_citycode = peconnect_data.try(:[], :coord).try(:[], "codeINSEE")
    asker.v_location_zipcode = peconnect_data.try(:[], :coord).try(:[], "codePostal")
    asker.v_location_city = peconnect_data.try(:[], :coord).try(:[], "libelleCommune")
    asker.v_location_country = peconnect_data.try(:[], :coord).try(:[], "libellePays")
    asker.v_location_label = asker.v_location_citycode + ' ' + asker.v_location_city
    asker.v_inscrit = _actual_inscrit(peconnect_data.try(:[], :statut).try(:[], "codeStatutIndividu"))

    asker
  end


  def _actual_age(str_birth)
    res = nil
    if str_birth
      dob = DateTime.strptime(str_birth, '%Y-%m-%dT%H:%M:%S%z')
      now = Date.today
      res = now.year - dob.year - (now.strftime('%m%d') < dob.strftime('%m%d') ? 1 : 0)
    end
    res
  end

  def _actual_inscrit(val)
    p '- - - - - - - - - - - - - - val- - - - - - - - - - - - - - - -' 
    pp val
    p ''
    res = ''
    if val == "0"
      res = "en_recherche"
    elsif val == "1"
      res = "oui"
    end
    res
  end

end
