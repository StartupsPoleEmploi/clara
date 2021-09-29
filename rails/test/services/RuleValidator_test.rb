require "test_helper"

class RuleValidatorTest < ActiveSupport::TestCase
  
  test '.nominal, valid rule' do
    #given
    rule = _valid_rule
    #when
    rule_is_valid = rule.valid?
    #then
    assert rule_is_valid
  end

  test 'missing kind' do
    #given
    rule = _valid_rule
    rule.kind = nil
    #when
    rule_is_valid = rule.valid?
    #then
    assert !rule_is_valid
    assert_equal(:kind, rule.errors.errors[0].attribute)
    assert_equal(:invalid, rule.errors.errors[0].type)
  end

  test 'composite : unauthorized, missing mandatory, and bad numericality of fields' do
    #given
    rule = Rule.new(
      kind: "composite", 
      name: "r_fake", 
      description: "age...", 
      slave_rules: [_valid_rule],
      value_eligible: "42")
    #when
    rule_is_valid = rule.valid?
    #then
    assert !rule_is_valid
    # unauthorized
    assert_equal(:value_eligible, rule.errors.errors[0].attribute)
    assert_equal(:present, rule.errors.errors[0].type)
    # mandatory
    assert_equal(:composition_type, rule.errors.errors[1].attribute)
    assert_equal(:blank, rule.errors.errors[1].type)
    # numerality
    assert_equal(:slave_rules, rule.errors.errors[2].attribute)
    assert_equal(:slave_rules_number, rule.errors.errors[2].type)
  end

  test 'simple : unauthorized, missing mandatory fields' do
    #given
    rule = _valid_rule
    rule.variable = nil
    rule.composition_type = "and_rule"
    #when
    rule_is_valid = rule.valid?
    #then
    assert !rule_is_valid
    # unauthorized
    assert_equal(:composition_type, rule.errors.errors[0].attribute)
    assert_equal(:present, rule.errors.errors[0].type)
    # mandatory
    assert_equal(:variable_id, rule.errors.errors[1].attribute)
    assert_equal(:blank, rule.errors.errors[1].type)
  end

  def _valid_rule
    v = Variable.new(name: 'v_fake', variable_kind: "string").tap(&:save!)
    Rule.new(
      name: "r_fake", 
      kind: "simple", 
      variable: v, 
      operator_kind: "more_than", 
      description: "age...", 
      value_eligible: "42")
  end

end
