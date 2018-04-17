
class DetailWhy < ViewObject

  def after_init(args)
    locals          = hash_for(args)
    @ability        = string_for(locals[:ability])
    @root_condition = string_for(locals[:root_condition])
    @root_rules     = array_for(locals[:root_rules])
  end

  def ability
    @ability
  end

  def root_condition
    @root_condition
  end

  def root_rules
    if @ability == 'eligible'
      return @root_rules.sort_by{|rule| rule[:status] == 'eligible' ? 0 : 1}
    elsif @ability == 'ineligible'
      return @root_rules.sort_by{|rule| rule[:status] == 'ineligible' ? 0 : 1}
    elsif @ability == 'uncertain'
      return @root_rules.sort_by{|rule| rule[:status] == 'uncertain' ? 0 : 1}
    end
    return []
  end

  def uncertain_sentence
    result = ""
    if @ability == 'uncertain'
      uncertain_rules_length = number_of_uncertain_rules
      number_of_rules = @root_rules.length
      result = "single-alone"   if number_of_rules == 1 && uncertain_rules_length == 1
      result = "single-amongst" if number_of_rules > 1 && uncertain_rules_length == 1 
      result = "plural-all"     if uncertain_rules_length > 1 && number_of_rules == uncertain_rules_length
      result = "plural"         if uncertain_rules_length > 1 && number_of_rules != uncertain_rules_length
    end
    return result
  end

  def number_of_uncertain_rules
    @root_rules.select{|rule| rule[:status] == 'uncertain'}.length
  end

  def all_conditions
    @root_rules.size > 1 && @root_rules.all? {|e| e[:status] == 'eligible'}
  end

  def no_condition
    @root_rules.size > 1 && @root_rules.all? {|e| e[:status] == 'ineligible'}
  end

end
