class GetGeoZone
    
  def call(aid)
    _h_to_text(ExtractGeoForAid.new.call(aid))
  end

  def _h_to_text(h)
    res = "Toute la France"
    if h[:selection] == "tout_sauf"
      res = "Toute la France, à l'exception #{_des_villes(h[:town], h[:department], h[:region])}#{_des_departements(h[:department], h[:region])}#{_des_regions(h[:region])}"
    end
    res
  end

  def _isnt_empty(array)
    array.is_a?(Array) && array.size > 0
  end

  def _des_villes(towns_array, departements_array, regions_array)
    res = ""
    if _isnt_empty(towns_array)
      "des villes #{towns_array.join(',')}"
      if (_isnt_empty(departements_array)) || (_isnt_empty(regions_array))
        res += ", "
      else
        res += "."
      end
    end
    res
  end

  def _des_departements(departements_array, regions_array)
    res = ""
    if _isnt_empty(departements_array)
      uniq = departements_array.size === 1
      res = "#{uniq ? "du" : "des"} département#{uniq ? "" : (s)} #{departements_array.map{|d| d.values[0]}.join(',')}"
      if _isnt_empty(regions_array)
        res += ", "
      else
        res += "."
      end
    end
  end

  def _des_regions(regions_array)
    res = ""
    if _isnt_empty(regions_array)
      uniq = regions_array.size === 1
      res = ", #{uniq ? "de la" : "des"} région#{uniq ? "" : (s)} #{regions_array.join(',')}."
    end
    res
  end

end