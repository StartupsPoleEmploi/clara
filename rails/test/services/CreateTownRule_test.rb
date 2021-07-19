require "test_helper"

class CreateTownRuleTest < ActiveSupport::TestCase
  

  test '.call creates a rule from Town, UUID, and operator_kind' do
    #given
    town = { '44109' => 'Nantes 44'}
    uuid = 'dpygzckqoerjsfuv'
    operator_kind = 'not_equal'
    v_location_citycode = Variable.new(name: 'v_location_citycode', variable_kind: "string").tap(&:save!)
    #when
    result = CreateTownRule.new.call(town, uuid, operator_kind)
    #then
    assert result.is_a?(Rule)
    assert result.name.start_with?('r_dpygzckqoerjsfuv_citycode_not_equal_44109_id_')
    assert_equal '44109', result.value_eligible
    assert_equal result.variable_id, v_location_citycode.id
    assert_equal result.description, 'Ne pas résider à Nantes 44'
    assert_equal result.kind, 'simple'
    assert_equal result.operator_kind, 'not_equal'
  end

end
