
class DetailConditionList < ViewObject

  def after_init(args)
    @ability_tree = hash_for(args[:ability_tree])
  end

  def html_output
    raw(_node_for(@ability_tree))
  end


  def _node_for(ability)
    res = ""
    res = 
    _and_or(ability) +
    "<ul>" +
      ability[:slave_rules].map do |sub_ability|
        if sub_ability[:composition_type].blank?
          "<li>" + sub_ability[:description] + "</li>"
        else
          "<li>" + _node_for(sub_ability) + "</li>"
        end
      end.join +
    "</ul>"
    res
  end


  def _and_or(ability)
    res = ""
    if ability[:composition_type] == "and_rule"
      res = "Toutes les conditions suivantes"
    elsif ability[:composition_type] == "or_rule"
      res = "Au moins une des conditions suivantes"
    end
    res
  end


  # def after_init(args)
  #   locals     = hash_for(args)
  #   @rules     = array_for(locals[:rules])
  # end

  # def rules
  #   @rules
  # end

  # def has_rules
  #   @rules.size > 0
  # end

  # def with_separator(condition)
  #   return "c-detail-condition__separator" if condition == _last_uncertain_rule && !_has_only_uncertain_rules
  #   return ""
  # end

  # def description_that_maybe_with_sigville(description)
  #   res = ""
  #   if description.is_a?(String)
  #     lower_description = description.downcase
  #     if lower_description.include?("quartier prioritaire") 
  #       res = description + ". Vous pouvez vérifier si votre adresse est en QPV ici : <a target='blank' href='https://sig.ville.gouv.fr/adresses/recherche'>https://sig.ville.gouv.fr/adresses/recherche</a>"
  #     else
  #       res = description
  #     end
  #   end
  #   res
  # end

  # def _has_only_uncertain_rules
  #   @rules.all? { |c| c[:status] == "uncertain" }
  # end

  # def _last_uncertain_rule
  #   @rules.find_all { |c| c[:status] == "uncertain" }.last
  # end
end
