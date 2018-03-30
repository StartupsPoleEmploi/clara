class Rule < ApplicationRecord
  include Prefixable
  has_paper_trail ignore: [:updated_at]

  enum operator_type: [:eq, :not_equal, :more_than, :less_than, :more_or_equal_than, :less_or_equal_than, :starts_with]
  enum composition_type: [:and_rule, :or_rule]

  has_many :compound_rules
  has_many :slave_rules, through: :compound_rules
  belongs_to :variable, optional: true

  has_many :aids
  has_many :contract_type
  has_many :custom_rule_checks

  validates :name, presence: true, uniqueness: true
  validate :validate_non_empty_rule, 
           :validate_non_ambiguous_type, 
           :validate_simple_rule_mandatory_fields, 
           :validate_complex_rule_mandatory_fields



  def validate_non_empty_rule
    return unless is_empty_rule?
    errors.add(:non_empty_rule, "Rule cannot be empty")
  end

  def validate_simple_rule_mandatory_fields
    return if is_complex_rule?
    return if (variable.present? && operator_type.present? && value_eligible.present?)
    errors.add(:simple_rule_mandatory_fields, "Variable, operator_type and value_eligible are mandatory")
  end

  def validate_non_ambiguous_type
    return unless is_ambiguous_rule?
    errors.add(:non_ambiguous_type, "Rule cannot be both simple and complex")
  end

  def validate_complex_rule_mandatory_fields
    return if is_simple_rule?
    return if (composition_type.present? && slave_rules.length > 0)
    errors.add(:complex_rule_mandatory_fields, "slave_rules and composition_type are mandatory")
  end

  def resolve criterion_hash = {}
    result = calculate_default_value
    if slave_rules.any?
      if and_rule?
        if slave_rules.all? { |slave_rule| slave_rule.resolve(criterion_hash) == "eligible" }
          result = "eligible"
        elsif slave_rules.any? { |slave_rule| slave_rule.resolve(criterion_hash) == "ineligible" }
          result = "ineligible"
        else
          result = "uncertain"
        end
      elsif or_rule?
        if slave_rules.any? { |slave_rule| slave_rule.resolve(criterion_hash) == "eligible" }
          result = "eligible"
        elsif slave_rules.all? { |slave_rule| slave_rule.resolve(criterion_hash) == "ineligible" }
          result = "ineligible"
        else
          result = "uncertain"
        end
      end
    else
      result = evaluate criterion_hash
    end
    result
  end

  def evaluate criterion_hash
    result = calculate_default_value
    c = criterion_hash.stringify_keys if criterion_hash.is_a?(Hash)
    if c && c.has_key?(variable.name) && c[variable.name].present?
      criterion_value = c[variable.name]
      rule_type = variable.variable_type
      return "ineligible" if !type_is_accurate(criterion_value, rule_type)
      return "ineligible" if criterion_value == "not_applicable"
      return "eligible" if calculate_is_eligible(criterion_value, rule_type)
      return "ineligible" if self.value_ineligible.blank?
      return "ineligible" if calculate_is_ineligible(criterion_value, rule_type)
    end
    return result
  end

  def is_simple_rule?
    variable.present? || operator_type.present? || value_eligible.present?
  end

  def is_complex_rule?
    slave_rules.length > 0 || composition_type.present?
  end

  def is_ambiguous_rule?
    is_simple_rule? && is_complex_rule?
  end

  def is_empty_rule?
    !is_simple_rule? && !is_complex_rule?
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
  def calculate_is_eligible(criterion_value, rule_type)
    calculate(criterion_value, self.value_eligible, rule_type)
  end
  def calculate_is_ineligible(criterion_value, rule_type)
    calculate(criterion_value, self.value_ineligible, rule_type)
  end

  def calculate(criterion_value, rule_value,  rule_type)

    typed_criterion_value = force_type_of(criterion_value, rule_type)
    typed_user_value = force_type_of(rule_value, rule_type)

    case self.operator_type
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
