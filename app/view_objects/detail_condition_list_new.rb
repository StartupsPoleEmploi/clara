
class DetailConditionListNew < ViewObject

  def after_init(args)
    locals          = hash_for(args)
    @conditions     = array_for(locals[:conditions])
    @rules = ActivatedModelsService.instance.rules
  end

  def conditions
    @conditions
  end

  def has_conditions
    @conditions.size > 0
  end

  def is_simple_condition(condition)
    actual_rule = @rules.detect{ |r| r["name"] == condition[:name] }
    actual_rule["slave_rules"].size == 0
  end

  def with_separator(condition)
    return "c-detail-condition__separator" if condition == _last_uncertain_rule && !_has_only_uncertain_rules
    return ""
  end

  def description_that_maybe_with_sigville(description)
    res = ""
    if description.is_a?(String)
      lower_description = description.downcase
      if lower_description.include?("quartier prioritaire") 
        res = description + ". Vous pouvez vérifier si votre adresse est en QPV ici : <a target='blank' href='https://sig.ville.gouv.fr/adresses/recherche'>https://sig.ville.gouv.fr/adresses/recherche</a>"
      else
        res = description
      end
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
