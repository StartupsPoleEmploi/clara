# HACK : please rename once new aid creation is released
class FindScopeAndGeoErrorsToo

  def call(trundle, geo)
    res = ""    
    sel = geo[:selection]
    editions = _deep_find(:is_editing, trundle, [])
    has_complex_geo = sel == "rien_sauf" || sel == "tout_sauf"
    
    no_geo = sel == "tout"
    no_box = _no_box(trundle)

    if no_geo && no_box 
      res = "Étape non renseignée."
    elsif !no_geo && no_box 
      res = "Il n'est pas possible d'indiquer un critère géographique seulement."
    elsif has_complex_geo && geo[:town].blank? && geo[:department].blank? && geo[:region].blank?
      res = "Il faut à minima renseigner une ville, ou un département, ou une région pour cette sélection géographique."
    elsif editions.any? && !no_box
      res = "Vous avez commencé à renseigner une condition, merci de terminer votre action ou de l'annuler"
    end

    res
  end

  def _no_box(trundle)
    t = trundle[:subboxes][0]
    trundle[:subboxes].size == 1 && t[:subcombination] == ""  && t[:subboxes] == [] && t[:xvar] == "" && t[:xop] == "" && t[:xval] == "" && t[:is_editing] == true
  end

  # https://stackoverflow.com/a/40743132/2595513
  def _deep_find(key, object, found=[])
    if object.respond_to?(:key?) && object.key?(key)
      found << object[key]
    end
    if object.is_a? Enumerable
      found << object.collect { |*a| _deep_find(key, a.last) }
    end
    found.flatten.compact
  end

end

