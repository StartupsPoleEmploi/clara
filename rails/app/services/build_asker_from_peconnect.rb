class BuildAskerFromPeconnect
  
  def call(peconnect_data)
    asker = Asker.new

    asker.v_age = _actual_age(peconnect_data.try(:[], :birth).try(:[], "dateDeNaissance"))
    asker.v_location_citycode = peconnect_data.try(:[], :coord).try(:[], "codeINSEE")
    asker.v_location_zipcode = peconnect_data.try(:[], :coord).try(:[], "codePostal")
    asker.v_location_city = peconnect_data.try(:[], :coord).try(:[], "libelleCommune")
    asker.v_location_country = peconnect_data.try(:[], :coord).try(:[], "libellePays")
    if !asker.v_location_zipcode.blank? && !asker.v_location_city.blank?
      asker.v_location_label = "#{asker.v_location_zipcode.to_s} #{asker.v_location_city.to_s}"
    end
    asker.v_inscrit = _actual_inscrit(peconnect_data.try(:[], :statut).try(:[], "codeStatutIndividu"))
    asker.v_duree_d_inscription = "non_inscrit" if asker.v_inscrit == "en_recherche"
    asker.v_diplome = _actual_grade(peconnect_data.try(:[], :formation))
    asker.v_allocation_type = _actual_alloc(peconnect_data.try(:[], :alloc).try(:[], "beneficiairePrestationSolidarite"))

    asker
  end

  def _actual_alloc(presta_solidarite)
    res = ''
    if presta_solidarite == true
      res = 'ARE_ASP'
    end
    res
  end

  def _actual_grade(grades)
    res = 'niveau_infra_5'
    found_grade = ''
    if grades.is_a?(Array)
      obtained = grades.select{|e| e["diplomeObtenu"] == true}
      if obtained.size > 0
        leveled = obtained.select{|e| e.try(:[], "niveau").try(:[], "code").to_s.start_with?('NV')}
        if leveled.size > 0
          sorted = leveled.sort_by { |e| e.try(:[], "niveau").try(:[], "code")}
          found_grade = sorted[0]["niveau"]["code"]
        end
      end
    end
    res = 'niveau_1' if found_grade == 'NV1'
    res = 'niveau_2' if found_grade == 'NV2'
    res = 'niveau_3' if found_grade == 'NV3'
    res = 'niveau_4' if found_grade == 'NV4'
    res = 'niveau_5' if found_grade == 'NV5'
    res
  end



  def _actual_age(str_birth)
    res = nil
    if str_birth
      dob = DateTime.strptime(str_birth, '%Y-%m-%dT%H:%M:%S%z')
      now = Date.today
      res = now.year - dob.year - (now.strftime('%m%d') < dob.strftime('%m%d') ? 1 : 0)
    end
    res.to_s
  end

  def _actual_inscrit(val)
    res = ''
    if val == "0"
      res = "en_recherche"
    elsif val == "1"
      res = "oui"
    end
    res
  end

end
