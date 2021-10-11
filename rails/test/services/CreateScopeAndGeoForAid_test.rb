require "test_helper"
    
class CreateScopeAndGeoForAidTest < ActiveSupport::TestCase

  test ".call, if trundle is empty, please detach rule from aid" do
    #given
    aid = _create_realistic_aid('aid_name')
    assert_not_nil aid.rule
    #when
    res = CreateScopeAndGeoForAid.new.call({trundle: {}, aid: aid})
    #then
    assert_nil aid.rule
  end

  test ".call, if trundle is empty, please detach rule from aid" do
    #given
    aid = _create_realistic_aid('aid_name')
    assert_not_nil aid.rule
    #when
    res = CreateScopeAndGeoForAid.new.call({trundle: {}, aid: aid})
    #then
    assert_nil aid.rule
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

