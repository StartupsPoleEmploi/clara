require "test_helper"
    
class RecordRegisterTest < ActiveSupport::TestCase

  test ".call" do
    #given
    session = OpenStruct.new({id: 'session_id'})
    asker = _create_realistic_asker
    url = ''
    rule, aid = _create_realistic_aid
    trace = Tracing.create!(name: "mobilite", description: 'descr', rule: rule, all_aids: true)
    #when
    res = RecordRegister.new.call(session, asker, url)
    #then
    assert_equal([{:tracing_id=>Tracing.last.id, :eligy=>"eligible"}], res)
  end


  def _create_realistic_aid
    variable_age = Variable.create!(name: "age", variable_kind: "integer")
    contract = ContractType.create!(name: "mobilite", ordre_affichage: 42)
    rule = Rule.create!({name: "r_majorite", value_eligible: "18", variable: variable_age, description: "descr", kind: "simple", operator_kind: "more_than"})
    aid = Aid.create!(name: "aaa", contract_type: contract, rule: rule, ordre_affichage: 3, what: 'x', how_and_when: 'y', how_much: 'z')
    [rule, aid]
  end

  def _create_realistic_asker
    Asker.new(
      v_handicap: "oui",
      v_spectacle: "non",
      v_cadre: "oui",
      v_diplome: 'niveau_3',
      v_category: 'autres_cat',
      v_duree_d_inscription: 'plus_d_un_an',
      v_allocation_value_min: 340,
      v_allocation_type: 'ARE_ASP',
      v_age: 35,
      v_location_citycode: '79351',
      v_location_zipcode: '91800',
    )
  end


end

