class RuletreeService

  def initialize(stubbed_rules=nil, stubbed_variables=nil)
    @all_rules = stubbed_rules || ActivatedModelsService.instance.rules
    @all_variables = stubbed_variables || ActivatedModelsService.instance.variables
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
      if !type_is_accurate(criterion_value, rule_type)
        result = "ineligible" 
      elsif calculate_is_eligible(rule, criterion_value, rule_type, elements)
        result = "eligible"
      else
        result = "ineligible"
      end
    end
    return result
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
    calculate(criterion_value, rule["operator_kind"], rule["value_eligible"], rule_type, elements)
  end

  def calculate(criterion_value, op_kind, rule_value, rule_type, elements)
    case rule_type
      when 'float'
        calculate_for_float(criterion_value, rule_value, op_kind)
      when 'integer'
        calculate_for_integer(criterion_value, rule_value, op_kind)
      when 'string'
        calculate_for_string(criterion_value, rule_value, op_kind)
      when 'selectionnable'
        calculate_for_selectionnable(criterion_value, rule_value, op_kind, elements)
      else
        false
    end
  end

  def calculate_for_float(criterion_value, rule_value, operator_kind)

    typed_criterion_value = criterion_value.to_s.gsub(",", ".").to_f
    typed_rule_value = rule_value.to_s.gsub(",", ".").to_f
    typed_list = rule_value.to_s.split(",")
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
        typed_list.include?(typed_criterion_value.to_s)
      when 'not_amongst'
        !typed_list.include?(typed_criterion_value.to_s)
      when 'starts_with'
        criterion_value.to_s.starts_with?(rule_value.to_s)
      when 'not_starts_with'
        !criterion_value.to_s.starts_with?(rule_value.to_s)
      else
        false
    end
  end

  def calculate_for_integer(criterion_value, rule_value, operator_kind)
    typed_criterion_value = criterion_value.to_i
    typed_rule_value = rule_value.to_i
    typed_list = rule_value.to_s.split(",")
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
        typed_list.include?(typed_criterion_value.to_s)
      when 'not_amongst'
        !typed_list.include?(typed_criterion_value.to_s)
      when 'starts_with'
        a = _removeaccents(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = _removeaccents(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        a.starts_with?(b)
      when 'not_starts_with'
        a = _removeaccents(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = _removeaccents(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
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
        a = _removeaccents(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = _removeaccents(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        a.starts_with?(b)
      when 'not_starts_with'
        a = _removeaccents(typed_criterion_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        b = _removeaccents(typed_rule_value.to_s).downcase.gsub(/[^0-9a-z]/i, '')
        !a.starts_with?(b)
      else
        false
    end
  end

  def calculate_for_selectionnable(criterion_value, rule_value, operator_kind, elements)
    indexof_criterion_value = elements.split(",").index(criterion_value)
    indexof_rule_value = elements.split(",").index(rule_value)
    indexof_rule_value ||= -1
    indexof_criterion_value ||= -1
    case operator_kind
      when 'equal'
        indexof_criterion_value == indexof_rule_value
      when 'not_equal'
        indexof_criterion_value != indexof_rule_value
      when 'more_than'
        indexof_criterion_value > indexof_rule_value
      when 'more_or_equal_than'
        indexof_criterion_value >= indexof_rule_value
      when 'less_than'
        indexof_criterion_value < indexof_rule_value
      when 'less_or_equal_than'
        indexof_criterion_value <= indexof_rule_value
      else
        false
    end
  end
  
  # Remove the accents from the string.
  # See https://gist.github.com/abelorian/8e2ea78f0601770336921fd254d39bdd
  def _removeaccents(str)
    res = String.new(str)   
    {
      'E' => [200,201,202,203],
      'e' => [232,233,234,235],
      'A' => [192,193,194,195,196,197],
      'a' => [224,225,226,227,228,229,230],
      'C' => [199],
      'c' => [231],
      'O' => [210,211,212,213,214,216],
      'o' => [242,243,244,245,246,248],
      'I' => [204,205,206,207],
      'i' => [236,237,238,239],
      'U' => [217,218,219,220],
      'u' => [249,250,251,252],
      'N' => [209],
      'n' => [241],
      'Y' => [221],
      'y' => [253,255],
      'AE' => [306],
      'ae' => [346],
      'OE' => [188],
      'oe' => [189]
    }.each {|letter,accents|
      packed = accents.pack('U*')
      rxp = Regexp.new("[#{packed}]", nil)
      res.gsub!(rxp, letter)
    }
    
    res
  end

  

end
