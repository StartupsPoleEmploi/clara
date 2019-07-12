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
    v  = build(:variable, :handicap)
    v.variable_kind = nil
    rule_under_test = build(:rule, :be_handicaped, variable: v)
    result = RuleCheckService.new.check_type(rule_under_test)
    assert_equal('error', result)
  end

  test '.check_type Return n/a if variable does not exists' do
    rule_under_test = build(:rule, :be_handicaped, variable: nil)
    result = RuleCheckService.new.check_type(rule_under_test)
    assert_equal('n/a', result)
  end

  test '.check_custom_rule Checks custom rules, and fills given array' do
    # given
    rule1 = create(:rule, :be_an_adult, name: 'for_check_custom_rule')
    cr1 = create(:custom_rule_check, result: 'ineligible', name: 'nominal', rule: rule1)
    cr2 = create(:custom_rule_check, result: 'uncertain', name: 'error', rule: rule1)
    all_compositions = []
    # when
    result = RuleCheckService.new.check_custom_rule(rule1, all_compositions)
    # then
    assert_equal(2, all_compositions.length)
    assert_equal("error", all_compositions[0][:result])
    assert_equal("ok", all_compositions[1][:result])
  end

  test '.extract_descriptions returns an empty array if anything wrong occurs' do
    # given
    # when
    sut = RuleCheckService.new.send :extract_descriptions, Date.new
    # then
    assert_equal([], sut)
  end

  def be_an_adult
    Rule.new(
      name: 'be_an_adult',
      variable: Variable.new(name: 'v_age', variable_kind: 'integer'),
      kind: 'simple',
      operator_kind: :more_than,
      value_eligible: '18'
    )
  end

end
