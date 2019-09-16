
class DetailWhy < ViewObject

  def after_init(args)
    @ability_tree = hash_for(args)
    @ability        = @ability_tree[:ability]
    @slave_rules    = @ability_tree[:slave_rules]
  end

  def ability
    @ability
  end

  def rule
    @ability_tree
  end

  def slave_rules
    if @ability == 'eligible'
      return @slave_rules.sort_by{|rule| rule[:ability] == 'eligible' ? 0 : 1}
    elsif @ability == 'ineligible'
      return @slave_rules.sort_by{|rule| rule[:ability] == 'ineligible' ? 0 : 1}
    elsif @ability == 'uncertain'
      return @slave_rules.sort_by{|rule| rule[:ability] == 'uncertain' ? 0 : 1}
    end
    return []
  end

  def uncertain_sentence
    result = ""
    if @ability == 'uncertain'
      uncertain_rules_length = number_of_uncertain_rules
      number_of_rules = @slave_rules.length
      result = "single-alone"   if number_of_rules == 1 && uncertain_rules_length == 1
      result = "single-amongst" if number_of_rules > 1 && uncertain_rules_length == 1 
      result = "plural-all"     if uncertain_rules_length > 1 && number_of_rules == uncertain_rules_length
      result = "plural"         if uncertain_rules_length > 1 && number_of_rules != uncertain_rules_length
    end
    return result
  end

  def eligible_sentence
    result = ""
    if @ability == 'eligible'
      eligible_rules_length = number_of_eligible_rules
      number_of_rules = @slave_rules.length
      result = "single-amongst" if number_of_rules > 1 && eligible_rules_length == 1 
      result = "plural"         if eligible_rules_length > 1 && number_of_rules != eligible_rules_length
    end
    return result
  end

  def number_of_uncertain_rules
    @slave_rules.select{|rule| rule[:ability] == 'uncertain'}.length
  end

  def number_of_eligible_rules
    @slave_rules.select{|rule| rule[:ability] == 'eligible'}.length
  end

  def all_conditions
    @slave_rules.size > 1 && @slave_rules.all? {|e| e[:ability] == 'eligible'}
  end

  def no_condition
    @slave_rules.size > 1 && @slave_rules.all? {|e| e[:ability] == 'ineligible'}
  end

end
