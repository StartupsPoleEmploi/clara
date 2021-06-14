require "test_helper"

class CreateToutSaufDomTomTest < ActiveSupport::TestCase
  
  test '.call? creates the right rules' do
    #given
    #when
    res = CreateToutSaufDomTom.new.call('uuid')
    #then
    assert_equal(true, res.is_a?(Rule))
    assert_equal(6, res.slave_rules.size)
    assert_equal("r_uuid_box_geo", res.name)
    assert_equal("and_rule", res.composition_type)    
  end

end
