
class DetailConditionList < ViewObject

  def after_init(args)
    locals          = hash_for(args)
    @conditions     = array_for(locals[:conditions])
  end

  def conditions
    @conditions
  end

  def has_conditions
    @conditions.size > 0
  end

  def with_separator(condition)
    return "c-detail-condition__separator" if condition == _last_uncertain_rule && !_has_only_uncertain_rules
    return ""
  end

  def description_that_maybe_with_sigville(description)
    res = ""
    if description.is_a?(String)
      lower_description = description.downcase
      res = description + " Vous pouvez vérifier si votre adresse est en QPV ici : https://sig.ville.gouv.fr/adresses/recherche"
    end
    res
  end

  def _has_only_uncertain_rules
    @conditions.all? { |c| c[:status] == "uncertain" }
  end

  def _last_uncertain_rule
    @conditions.find_all { |c| c[:status] == "uncertain" }.last
  end
end
