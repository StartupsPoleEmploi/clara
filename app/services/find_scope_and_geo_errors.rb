class FindScopeAndGeoErrors

  def call(trundle, geo)
    res = ""    
    sel = geo["selection"]
    editions = trundle.deep_find("is_editing")
    has_complex_geo = sel == "rien_sauf" || sel == "tout_sauf"

    if has_complex_geo
      if geo["town"].blank? && geo["department"].blank? && geo["region"].blank?
        res = "Veuillez renseigner un critère géographique"
      end
    elsif editions.any?
      res = "Veuillez terminer l'édition d'une condition avant de valider le champ d'application"
    end

    res
  end

  # https://stackoverflow.com/a/40743132/2595513
  def deep_find(key, object, found=[])
    if object.respond_to?(:key?) && object.key?(key)
      found << object[key]
    end
    if object.is_a? Enumerable
      found << object.collect { |*a| deep_find(key, a.last) }
    end
    found.flatten.compact
  end

end

