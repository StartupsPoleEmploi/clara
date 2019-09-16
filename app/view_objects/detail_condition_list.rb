
class DetailConditionList < ViewObject

  def after_init(args)
    @ability_tree = hash_for(args[:ability_tree])
  end

  def html_output
    res = ""
    if @ability_tree[:slave_rules].size == 0
      res = "il faut remplir la condition suivante : " + "<ul><li>" + _and_or(@ability_tree) + _eligibility(@ability_tree) + @ability_tree[:description] + "</li></ul>"
    else
      res = "il faut réunir " + _node_for(@ability_tree, {}, 0, true)
    end
    raw(res)
  end


  def _node_for(ability, parent_ability, i, skip_img=false)
    _and_or(parent_ability, i) + _eligibility(ability, skip_img)  + _all_or_at_least(ability) +
    "<ol>" +
      ability[:slave_rules].map.with_index do |sub_ability, indx|
        if sub_ability[:composition_type].blank?
          "<li>" + _and_or(ability, indx) + _eligibility(sub_ability) + sub_ability[:description] + "</li>"
        else
          "<li>" + _node_for(sub_ability, ability, indx) +  "</li>"
        end
      end.join +
    "</ol>"
  end


  def _all_or_at_least(ability)
    res = ""
    if ability[:composition_type] == "and_rule"
      res = "l'ensemble des #{ability[:slave_rules].size} conditions suivantes"
    elsif ability[:composition_type] == "or_rule"
      res = "au moins une des conditions suivantes"
    end
    res
  end

  def _and_or(ability, number=-1)
    res = ""
    # if ability[:composition_type] == "and_rule" && number == 0
    #   res = "<strong>1) </strong>"
    # elsif ability[:composition_type] == "and_rule"
    #   res = "<strong>et #{number+1}) </strong>"
    if ability[:composition_type] == "and_rule"
      res = "<strong> </strong>"
    elsif ability[:composition_type] == "or_rule"
      res = "<strong>soit </strong>"
    end
    res
  end

  def _eligibility(ability, skip_img=false)
    res = ""
    unless skip_img
      if ability[:ability] == "eligible"
        res = "✅"
      elsif ability[:ability] == "uncertain"
        res = "<strong class='orangify'>❓</strong>"
      elsif ability[:ability] == "ineligible"
        res = "❌"
      end
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
