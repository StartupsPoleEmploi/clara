require "test_helper"
    
class JustificationServiceTest < ActiveSupport::TestCase

  test ".root_rules, always send back an array" do
    #given
    #when
    res = JustificationService.new(nil).root_rules
    #then
    assert res.is_a?(Array)
    assert_equal(0, res.size)
  end

  test ".root_rules, one simple condition" do
    #given
    aid = _create_realistic_aid('aid_name')
    #when
    res = JustificationService.new(aid).root_rules
    #then
    assert res.is_a?(Array)
    assert_equal(1, res.size)
    assert res[0].is_a?(Rule)
    assert_equal res[0], aid.rule
  end

  test ".root_condition, always send back a String" do
    #given
    aid = _create_realistic_aid('aid_name')
    #when
    res = JustificationService.new(aid).root_condition
    #then
    assert_equal 'one', res
  end

  test ".root_condition, simple case" do
    #given
    #when
    res = JustificationService.new(nil).root_condition
    #then
    assert_equal('', res)
  end

  def _create_realistic_aid(aid_name)
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    rule = Rule.create!({name: "r_majorite", value_eligible: "18", variable: variable_age, description: "descr", kind: "simple", operator_kind: "more_than"})
    aid = Aid.create!(name: aid_name, contract_type: contract, rule: rule, ordre_affichage: 3, what: 'x', how_and_when: 'y', how_much: 'z')
    filter = Filter.create!(name: "Se déplacer", aids: [aid])
    aid
  end


end

