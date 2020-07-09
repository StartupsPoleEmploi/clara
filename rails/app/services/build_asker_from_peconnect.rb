class BuildAskerFromPeconnect
  
  def call(peconnect_data)
    asker = Asker.new
    asker.v_age = _actual_age(peconnect_data.try(:[], :birth).try(:[], "dateDeNaissance"))
    asker.v_location_citycode = peconnect_data.try(:[], :coord).try(:[], "codeINSEE")
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

end
