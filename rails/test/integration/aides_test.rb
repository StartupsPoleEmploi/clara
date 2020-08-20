require 'test_helper'

class AidesTest < ActionDispatch::IntegrationTest

  test "Aides : result screen, with active user" do
    #given
    _create_realistic_aid('my aid')
    allow_any_instance_of(GetCityNameRegionCode).to receive(:call).and_return(['Ceyssac', 'ARA'])

    
    #when
    get aides_path(for_id: 'NDUsNCxvLDEsMyxuLG0sNDMwNDUsNDMwMDAsbm90X2FwcGxpY2FibGUsbg==')
    #then
    assert_response :success
    assert_select '.c-resultaid.is-eligible', 1
    assert_equal 'my aid', text_of('h3.c-resultaid__smalltitle')
    assert_select '.c-resultaid.is-ineligible', 0
    assert_select '.c-resultaid.is-uncertain', 0
  end

  test "Aides : result screen, simple search without active user" do
    #given
    _create_realistic_aid('super_aid')
    #when
    get aides_path
    #then
    assert_response :success
    assert_equal 'super_aid', text_of('h2.c-result-aid__title a')
  end


  def _create_realistic_aid(aid_name)
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    rule = Rule.create!({name: "r_majorite", value_eligible: "18", variable: variable_age, description: "descr", kind: "simple", operator_kind: "more_than"})
    aid = Aid.create!(name: aid_name, contract_type: contract, rule: rule, ordre_affichage: 3, what: 'x', how_and_when: 'y', how_much: 'z')
    filter = Filter.create!(name: "Se déplacer", aids: [aid])
  end


end
