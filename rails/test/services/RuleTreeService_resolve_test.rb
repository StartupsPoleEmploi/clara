require "test_helper"

class RuleTreeServiceResolveTest < ActiveSupport::TestCase


  test ".resolve can return 'eligible' for a string" do
    #given
    c = _empty_criterion_h
    c["v_location_citycode"] = "62193"
    r = rule_named("r_pas_de_calais")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("eligible", res)
  end
  test ".resolve can return 'ineligible' for a string" do
    #given
    c = _empty_criterion_h
    c["v_location_citycode"] = "59350"
    r = rule_named("r_pas_de_calais")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("ineligible", res)
  end
  test ".resolve can return 'uncertain' for a string" do
    #given
    c = _empty_criterion_h
    r = rule_named("r_pas_de_calais")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("uncertain", res)
  end


  test ".resolve can return 'eligible' for a integer" do
    #given
    c = _empty_criterion_h
    c["v_age"] = "17"
    r = rule_named("r_age_inf_32")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("eligible", res)
  end
  test ".resolve can return 'ineligible' for a integer" do
    #given
    c = _empty_criterion_h
    c["v_age"] = "42"
    r = rule_named("r_age_inf_32")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("ineligible", res)
  end
  test ".resolve can return 'uncertain' for a integer" do
    #given
    c = _empty_criterion_h
    r = rule_named("r_age_inf_32")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("uncertain", res)
  end


  test ".resolve can return 'eligible' for a selectionnable" do
    #given
    c = _empty_criterion_h
    c["v_detenu"] = "oui"
    r = rule_named("r_detenu")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("eligible", res)
  end
  test ".resolve can return 'ineligible' for a selectionnable" do
    #given
    c = _empty_criterion_h
    c["v_detenu"] = "non"
    r = rule_named("r_detenu")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("ineligible", res)
  end
  test ".resolve can return 'uncertain' for a selectionnable" do
    #given
    c = _empty_criterion_h
    r = rule_named("r_detenu")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("uncertain", res)
  end


  test ".resolve can return 'eligible' for an AND rule" do
    #given
    c = _empty_criterion_h
    c["v_age"] = "25"
    r = rule_named("r_age_sup_18_et_age_inf_32")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("eligible", res)
  end
  test ".resolve can return 'ineligible' for an AND rule" do
    #given
    c = _empty_criterion_h
    c["v_age"] = "17"
    r = rule_named("r_age_sup_18_et_age_inf_32")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("ineligible", res)
  end
  test ".resolve can return 'uncertain' for an AND rule" do
    #given
    c = _empty_criterion_h
    r = rule_named("r_age_sup_18_et_age_inf_32")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("uncertain", res)
  end


  test ".resolve can return 'eligible' for an OR rule" do
    #given
    c = _empty_criterion_h
    c["v_location_citycode"] = "62193"
    r = rule_named("r_nord_pas_de_calais")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("eligible", res)
  end
  test ".resolve can return 'ineligible' for an OR rule" do
    #given
    c = _empty_criterion_h
    c["v_location_citycode"] = "44220"
    r = rule_named("r_nord_pas_de_calais")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("ineligible", res)
  end
  test ".resolve can return 'uncertain' for an OR rule" do
    #given
    c = _empty_criterion_h
    r = rule_named("r_nord_pas_de_calais")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("uncertain", res)
  end


  test ".resolve can return 'eligible' for a DEEP_AND rule" do
    #given
    c = _empty_criterion_h
    c["v_location_citycode"] = "59350"
    c["v_age"] = "29"
    r = rule_named("r_deep")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("eligible", res)
  end
  test ".resolve can return 'ineligible' for a DEEP_AND rule" do
    #given
    c = _empty_criterion_h
    c["v_location_citycode"] = "59350"
    c["v_age"] = "34"
    r = rule_named("r_deep")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("ineligible", res)
  end
  test ".resolve can return 'uncertain' for a DEEP_AND rule" do
    #given
    c = _empty_criterion_h
    c["v_age"] = "23"
    r = rule_named("r_deep")
    #when
    res = RuletreeService.new(_rules, _variables).resolve(r, c)
    #then
    assert_equal("uncertain", res)
  end

  def rule_named(name)
    _rules.find { |r| r["name"] == name  }["id"]
  end

  def _empty_criterion_h
    {"v_handicap"=>nil,
     "v_spectacle"=>nil,
     "v_cadre"=>nil,
     "v_diplome"=>nil,
     "v_category"=>nil,
     "v_duree_d_inscription"=>nil,
     "v_allocation_value_min"=>nil,
     "v_allocation_type"=>nil,
     "v_qpv"=>nil,
     "v_zrr"=>nil,
     "v_age"=>nil,
     "v_location_label"=>nil,
     "v_location_route"=>nil,
     "v_location_city"=>nil,
     "v_location_country"=>nil,
     "v_location_zipcode"=>nil,
     "v_location_citycode"=>nil,
     "v_location_street_number"=>nil,
     "v_location_state"=>nil}
   end

   def _variables
    [
      {"id"=>1,
        "name"=>"v_age",
        "description"=>"",
        "elements"=>"",
        "name_translation"=>"âge",
        "elements_translation"=>"",
        "variable_kind"=>"integer"},
      {"id"=>19,
        "name"=>"v_location_citycode",
        "description"=>"",
        "elements"=>"",
        "name_translation"=>"geo : code INSEE de la ville",
        "elements_translation"=>"",
        "variable_kind"=>"string"},
      {"id" => 16,
        "name" => "v_detenu",
        "description" => "",
        "elements" => "oui,non",
        "name_translation" => "est detenu ou ancien detenu",
        "elements_translation" => "",
        "variable_kind" => "selectionnable"
      }
    ]
   end

   def _rules
    [
      # Simple selectionnable
      {
        "id" => 50,
        "name" => "r_detenu",
        "value_eligible" => "oui",
        "variable_id" => 16,
        "operator_kind" => "equal",
        "slave_rules" => []
      },
      # Simples integer
      {
        "id" => 220,
        "name" => "r_age_inf_32",
        "value_eligible" => "32",
        "variable_id" => 1,
        "operator_kind" => "less_or_equal_than",
        "slave_rules" => []
      },
      {
        "id" => 61,
        "name" => "r_age_sup_18",
        "value_eligible" => "17",
        "variable_id" => 1,
        "operator_kind" => "more_than",
        "slave_rules" => []
      },
      # Simples string
      {
        "id" => 211,
        "name" => "r_pas_de_calais",
        "value_eligible" => "62",
        "variable_id" => 19,
        "operator_kind" => "starts_with",
        "slave_rules" => []
      },
      {
        "id" => 173,
        "name" => "r_nord",
        "value_eligible" => "59",
        "variable_id" => 19,
        "operator_kind" => "starts_with",
        "slave_rules" => []
      },
      # And Rule
      {
        "id" => 221,
        "name" => "r_age_sup_18_et_age_inf_32",
        "composition_type" => "and_rule",
        "slave_rules" => [
          {
            "id" => 220,
            "name" => "r_age_inf_32"
          },
          {
            "id" => 61,
            "name" => "r_age_sup_18"
          }
        ]
      },
      # Or rule
      {
        "id" => 212,
        "name" => "r_nord_pas_de_calais",
        "composition_type" => "or_rule",
        "slave_rules" => [
          {
          "id" => 173,
          "name" => "r_nord"
          },
          {
          "id" => 211,
          "name" => "r_pas_de_calais"
          }
        ]
      },
      # Deep rule
      {
        "id" => 333,
        "name" => "r_deep",
        "composition_type" => "and_rule",
        "slave_rules" => [
          {
          "id" => 212,
          "name" => "r_nord_pas_de_calais"
          },
          {
          "id" => 221,
          "name" => "r_age_sup_18_et_age_inf_32"
          }
        ]
      }
    ]
  end

end
