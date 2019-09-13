
class DetailWhyNew < ViewObject

  def after_init(args)
    locals          = hash_for(args)
    @root_condition = string_for(locals[:root_condition])
    @ability        = @root_condition[:ability]
    @slaves_rules   = array_for(locals[:slaves_rules])
  end

  def ability
    @ability
  end

  def root_condition
    @root_condition
  end

  def slaves_rules
    if @ability == 'eligible'
      return @slaves_rules.sort_by{|rule| rule[:status] == 'eligible' ? 0 : 1}
    elsif @ability == 'ineligible'
      return @slaves_rules.sort_by{|rule| rule[:status] == 'ineligible' ? 0 : 1}
    elsif @ability == 'uncertain'
      return @slaves_rules.sort_by{|rule| rule[:status] == 'uncertain' ? 0 : 1}
    end
    return []
  end

  def uncertain_sentence
    result = ""
    if @ability == 'uncertain'
      uncertain_rules_length = number_of_uncertain_rules
      number_of_rules = @slaves_rules.length
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
      number_of_rules = @slaves_rules.length
      result = "single-amongst" if number_of_rules > 1 && eligible_rules_length == 1 
      result = "plural"         if eligible_rules_length > 1 && number_of_rules != eligible_rules_length
    end
    return result
  end

  def number_of_uncertain_rules
    @slaves_rules.select{|rule| rule[:status] == 'uncertain'}.length
  end

  def number_of_eligible_rules
    @slaves_rules.select{|rule| rule[:status] == 'eligible'}.length
  end

  def all_conditions
    @slaves_rules.size > 1 && @slaves_rules.all? {|e| e[:status] == 'eligible'}
  end

  def no_condition
    @slaves_rules.size > 1 && @slaves_rules.all? {|e| e[:status] == 'ineligible'}
  end

end
