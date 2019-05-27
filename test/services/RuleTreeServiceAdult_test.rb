require "test_helper"

class RuleTreeServiceAdultTest < ActiveSupport::TestCase

  def setup
  end

  def teardown
  end
  
  test ".evaluate should return 'eligible' when criteria is present and satisfied" do
    #given
    rule = Rule.new(name: "adult", kind: "simple", variable: Variable.new(name: "age", variable_kind: :integer), operator_kind: :more_than, value_eligible: "18")
    criterion_h = {v_age: "34"}
    #when
    res = RuletreeService.new(nil, _variables).evaluate(rule, criterion_h)
    #then
    assert_equal("eligible", res)
  end

  def _adult_rule_h
    {"id"=>195,
      "name"=>"r_adult",
      "value_eligible"=>"18",
      "variable_id"=>23,
      "operator_kind"=>"more_or_equal_than",
      "slave_rules"=>[]}
  end

  def _variables
     [{"id"=>23,
        "name"=>"v_age",
        "description"=>"",
        "elements"=>"",
        "name_translation"=>"âge",
        "elements_translation"=>"",
        "variable_kind"=>"integer"}]
  end
end
