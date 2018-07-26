class RuletreeService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def RuletreeService.set_instance(the_double)
    @@the_double = the_double
  end

  def RuletreeService.get_instance
    @@the_double.nil? ? RuletreeService.new : @@the_double
  end

  def initialize
    @all_rules = ActivatedModelsService.instance.rules
    @all_variables = ActivatedModelsService.instance.variables
  end

  def resolve(rule_id, criterion_hash = {}) 
    result = calculate_default_value
    current_rule = @all_rules.detect{|one_rule| one_rule["id"] == rule_id}
    return result unless current_rule.is_a?(Hash) && current_rule["slave_rules"]
    if current_rule["slave_rules"].any?
      if current_rule["composition_type"] == "and_rule"
        if current_rule["slave_rules"].all? { |slave_rule| resolve(slave_rule["id"], criterion_hash) == "eligible" }
          result = "eligible"
        elsif current_rule["slave_rules"].any? { |slave_rule| resolve(slave_rule["id"], criterion_hash) == "ineligible" }
          result = "ineligible"
        else
          result = "uncertain"
        end
      elsif current_rule["composition_type"] == "or_rule"
        if current_rule["slave_rules"].any? { |slave_rule| resolve(slave_rule["id"], criterion_hash) == "eligible" }
          result = "eligible"
        elsif current_rule["slave_rules"].all? { |slave_rule| resolve(slave_rule["id"], criterion_hash) == "ineligible" }
          result = "ineligible"
        else
          result = "uncertain"
        end
      end
    else
      result = evaluate(current_rule, criterion_hash)
    end
    result
  end

  def evaluate(rule, criterion_hash)
    result = calculate_default_value
    c = criterion_hash.stringify_keys if criterion_hash.is_a?(Hash)
    variable = @all_variables.detect { |e| e["id"] == rule["variable_id"] }
    if c && variable && c.has_key?(variable["name"]) && c[variable["name"]].present?
      criterion_value = c[variable["name"]]
      rule_type = variable["variable_type"]
      return "ineligible" if !type_is_accurate(criterion_value, rule_type)
      return "ineligible" if criterion_value == "not_applicable"
      return "eligible" if calculate_is_eligible(rule, criterion_value, rule_type)
      return "ineligible" if rule["value_ineligible"].blank?
      return "ineligible" if calculate_is_ineligible(rule, criterion_value, rule_type)
    end
    return result
  end

  def _all_rules
    @all_rules
  end

  def _stub_all_rules(rules)
    @all_rules = rules
    self
  end

  private

  def type_is_accurate(the_value, the_type)
    return false if the_value == nil || the_type == nil
    return false if the_type == 'integer' && !the_value.to_s.match(/^(\d)+$/) 
    return true
  end
  def calculate_default_value
    "uncertain"
  end
  def calculate_is_eligible(rule, criterion_value, rule_type)
    calculate(rule, criterion_value, rule["value_eligible"], rule_type)
  end
  def calculate_is_ineligible(rule, criterion_value, rule_type)
    calculate(rule, criterion_value, rule["value_ineligible"], rule_type)
  end

  def calculate(rule, criterion_value, rule_value,  rule_type)

    typed_criterion_value = force_type_of(criterion_value, rule_type)
    typed_user_value = force_type_of(rule_value, rule_type)

    case rule["operator_type"]
      when 'eq'
        typed_criterion_value == typed_user_value
      when 'not_equal'
        typed_criterion_value != typed_user_value
      when 'more_than'
        typed_criterion_value > typed_user_value
      when 'more_or_equal_than'
        typed_criterion_value >= typed_user_value
      when 'less_or_equal_than'
        typed_criterion_value <= typed_user_value
      when 'less_than'
        typed_criterion_value < typed_user_value
      when 'starts_with'
        a = ActiveSupport::Inflector.transliterate(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = ActiveSupport::Inflector.transliterate(typed_user_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        a.starts_with?(b)
      else
        false
    end
  end

  def force_type_of(the_value, the_type)
    case the_type
      when 'integer'
        the_value.to_i
      when 'string'
        the_value.to_s
      else
        the_value
    end
  end



end
