require "test_helper"

class RuleTreeServiceEvaluateTest < ActiveSupport::TestCase

  
  test ".evaluate should return 'eligible' when criteria is present and satisfied, integer" do
    #given
    r = _adult_rule_h
    c = {v_age: "34"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("eligible", res)
  end

  test ".evaluate should return 'eligible' when criteria is present and satisfied, selectionnable" do
    #given
    r = _other_cat_h
    c = {v_category: "autres_cat"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("eligible", res)
  end

  test ".evaluate should return ineligible for unexisting value" do
    #given
    r = _other_cat_h
    c = {v_category: "unexisting"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("ineligible", res)
  end

  test ".evaluate should return 'eligible' when criteria is present and satisfied - limit case" do
    #given
    r = _adult_rule_h
    c = {v_age: "18"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("eligible", res)
  end

  test ".evaluate should return 'ineligible' when criteria is present but not satisfied" do
    #given
    r = _adult_rule_h
    c = {v_age: "17"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("ineligible", res)
  end

  test ".evaluate should return 'ineligible' when criteria is present but has a wrong type" do
    #given
    r = _adult_rule_h
    c = {v_age: "wrong_type"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("ineligible", res)
  end

  test ".evaluate should return 'uncertain' when criterion hash is empty" do
    #given
    r = _adult_rule_h
    c = {}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("uncertain", res)
  end

  test ".evaluate should return 'uncertain' when criteria is not here" do
    #given
    r = _adult_rule_h
    c = {v_foo: "bar"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(r, c)
    #then
    assert_equal("uncertain", res)
  end



  def _adult_rule_h
    {"id"=>195,
      "name"=>"r_adult",
      "value_eligible"=>"18",
      "variable_id"=>23,
      "operator_kind"=>"more_or_equal_than",
      "slave_rules"=>[]}
  end

  def _other_cat_h
    {
      "id" => 7,
      "name" => "r_categorie_autre_que_12345",
      "value_eligible" => "autres_cat",
      "variable_id" => 6,
      "operator_kind" => "equal",
      "slave_rules" => []
    }
  end

  def _variables
     [
      {"id"=>23,
        "name"=>"v_age",
        "description"=>"",
        "elements"=>"",
        "name_translation"=>"âge",
        "elements_translation"=>"",
        "variable_kind"=>"integer"},
      {"id" => 6,
        "name" => "v_category",
        "description" => "",
        "elements" => "cat_12345,autres_cat",
        "name_translation" => "categorie",
        "elements_translation" => "1 a 5, autres categories",
        "variable_kind" => "selectionnable"}
      ]
  end
end
