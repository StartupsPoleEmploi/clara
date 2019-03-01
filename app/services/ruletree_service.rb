class RuletreeService

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
      rule_type = variable["variable_kind"]
      elements = variable["elements"]
      return "ineligible" if !type_is_accurate(criterion_value, rule_type)
      return "ineligible" if criterion_value == "not_applicable"
      return "eligible" if calculate_is_eligible(rule, criterion_value, rule_type, elements)
      return "ineligible"
    end
    return result
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
  def calculate_is_eligible(rule, criterion_value, rule_type, elements)
    calculate(rule, criterion_value, rule["value_eligible"], rule_type, elements)
  end

  def calculate(rule, criterion_value, rule_value, rule_type, elements)
    # p '- - - - - - - - - - - - - - rule- - - - - - - - - - - - - - - -' 
    # pp rule
    # p ''
    # p '- - - - - - - - - - - - - - criterion_value- - - - - - - - - - - - - - - -' 
    # pp criterion_value
    # p ''
    # p '- - - - - - - - - - - - - - rule_value- - - - - - - - - - - - - - - -' 
    # pp rule_value
    # p ''
    # p '- - - - - - - - - - - - - - rule_type- - - - - - - - - - - - - - - -' 
    # pp rule_type
    # p ''
    # p '- - - - - - - - - - - - - - elements- - - - - - - - - - - - - - - -' 
    # pp elements
    # p ''
    allowed_types = ['integer', 'string', 'selectionnable']
    allowed_operators = ['equal', 'not_equal', 'more_than', 'more_or_equal_than', 'less_than', 'less_or_equal_than', 'amongst', 'not_amongst', 'starts_with', 'not_starts_with']
    op = rule["operator_kind"]
    return false unless allowed_types.include?(rule_type) && allowed_operators.include?(op)
    case rule_type
      when 'integer'
        calculate_for_integer(criterion_value, rule_value, op)
      when 'string'
        calculate_for_string(criterion_value, rule_value, op)
      when 'selectionnable'
        calculate_for_selectionnable(criterion_value, rule_value, op, elements)
      else
        false
    end
  end

  def calculate_for_integer(criterion_value, rule_value, operator_kind)
    typed_criterion_value = criterion_value.to_i
    typed_rule_value = rule_value.to_i
    case operator_kind
      when 'equal'
        typed_criterion_value == typed_rule_value
      when 'not_equal'
        typed_criterion_value != typed_rule_value
      when 'more_than'
        typed_criterion_value > typed_rule_value
      when 'more_or_equal_than'
        typed_criterion_value >= typed_rule_value
      when 'less_or_equal_than'
        typed_criterion_value <= typed_rule_value
      when 'less_than'
        typed_criterion_value < typed_rule_value
      when 'amongst'
        typed_rule_value.split(",").include?(typed_criterion_value)
      when 'not_amongst'
        !typed_rule_value.split(",").include?(typed_criterion_value)
      when 'starts_with'
        a = ActiveSupport::Inflector.transliterate(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = ActiveSupport::Inflector.transliterate(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        a.starts_with?(b)
      when 'not_starts_with'
        a = ActiveSupport::Inflector.transliterate(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = ActiveSupport::Inflector.transliterate(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        !a.starts_with?(b)
      else
        false
    end
  end

  def calculate_for_string(criterion_value, rule_value, operator_kind)
    typed_criterion_value = criterion_value.to_s
    typed_rule_value = rule_value.to_s
    case operator_kind
      when 'equal'
        typed_criterion_value == typed_rule_value
      when 'not_equal'
        typed_criterion_value != typed_rule_value
      when 'more_than'
        typed_criterion_value > typed_rule_value
      when 'more_or_equal_than'
        typed_criterion_value >= typed_rule_value
      when 'less_or_equal_than'
        typed_criterion_value <= typed_rule_value
      when 'less_than'
        typed_criterion_value < typed_rule_value
      when 'amongst'
        typed_rule_value.split(",").include?(typed_criterion_value)
      when 'not_amongst'
        !typed_rule_value.split(",").include?(typed_criterion_value)
      when 'starts_with'
        a = ActiveSupport::Inflector.transliterate(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = ActiveSupport::Inflector.transliterate(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        a.starts_with?(b)
      when 'not_starts_with'
        a = ActiveSupport::Inflector.transliterate(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = ActiveSupport::Inflector.transliterate(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        !a.starts_with?(b)
      else
        false
    end
  end

  def calculate_for_selectionnable(criterion_value, rule_value, operator_kind, elements)
    indexof_criterion_value = elements.split(",").index(criterion_value)
    indexof_rule_value = elements.split(",").index(rule_value)
    case operator_kind
      when 'equal'
        indexof_criterion_value == indexof_rule_value
      when 'not_equal'
        indexof_criterion_value != indexof_rule_value
      when 'more_than'
        indexof_criterion_value > indexof_rule_value
      when 'more_or_equal_than'
        indexof_criterion_value >= indexof_rule_value
      else
        false
    end
  end

end
