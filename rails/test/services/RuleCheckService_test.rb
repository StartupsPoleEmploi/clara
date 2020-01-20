require "test_helper"

class RuleCheckServiceTest < ActiveSupport::TestCase

  test '.check_type Can validate a well-formed rule' do
    rule_under_test = be_an_adult
    result = RuleCheckService.new.check_type(rule_under_test)
    assert_equal('ok', result)
  end

  test '.check_type Can validate a string rule' do
    #given
    rule_under_test = be_an_adult
    rule_under_test.variable.variable_kind = 'string'
    #when
    result = RuleCheckService.new.check_type(rule_under_test)
    #then
    assert_equal('ok', result)
  end

  test '.check_type Can validate a string rule with starts_with' do
    #given
    rule_under_test = be_an_adult
    rule_under_test.operator_kind = 'starts_with'
    #when
    result = RuleCheckService.new.check_type(rule_under_test)
    #then
    assert_equal('ok', result)
  end

  test '.check_type Return error, if rule.value_eligible is wrong type' do
    #given
    rule_under_test = be_an_adult
    rule_under_test.value_eligible = "a_string"
    #when
    result = RuleCheckService.new.check_type(rule_under_test)
    #then
    assert_equal('error', result)
  end

  test '.check_type Return error if rule.variable.variable_kind does not exists' do
    # given
    rule_under_test = be_an_adult
    rule_under_test.variable.variable_kind = nil
    # when
    result = RuleCheckService.new.check_type(rule_under_test)
    # then
    assert_equal('error', result)
  end

  test '.check_type Return n/a if variable does not exists' do
    # given
    rule_under_test = be_an_adult
    rule_under_test.variable = nil
    # when
    result = RuleCheckService.new.check_type(rule_under_test)
    # then
    assert_equal('n/a', result)
  end

  test '.check_custom_rule Checks custom rules, and fills given array' do
    # given
    cr1 = crc('nominal', 'ineligible')
    cr2 = crc('error', 'uncertain')
    rule1 = be_an_adult
    rule1.custom_rule_checks = [cr1, cr2]
    all_compositions = []
    allow_any_instance_of(RuletreeService).to receive(:resolve).and_return('ineligible')
    # when
    result = RuleCheckService.new.check_custom_rule(rule1, all_compositions)
    # then
    assert_equal(2, all_compositions.length)
    assert_equal("ok", all_compositions[0][:result])
    assert_equal("error", all_compositions[1][:result])
  end

  test '.extract_descriptions returns an an array when description has comma-separated values' do
    rule = be_an_adult
    rule.variable.elements = 'a,b,c'
    sut = RuleCheckService.new.send :extract_descriptions, rule
    assert_equal(['a', 'b', 'c'], sut)
  end

  test '.extract_descriptions returns an empty array if anything wrong occurs' do
    sut = RuleCheckService.new.send :extract_descriptions, Date.new
    assert_equal([], sut)
  end

  def crc(name, result)
    CustomRuleCheck.new(
      name: name,
      result: result,
    )
  end

  def be_an_adult
    Rule.new(
      id: 42,
      name: 'be_an_adult',
      variable: variable_age,
      kind: 'simple',
      operator_kind: :more_than,
      value_eligible: '18'
    )
  end

  def variable_age
    Variable.new(name: 'v_age', variable_kind: 'integer')
  end

end
