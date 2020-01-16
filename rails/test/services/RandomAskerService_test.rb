require "test_helper"

class RandomAskerServiceTest < ActiveSupport::TestCase  
  test '.go Should return an Asker' do
    res = RandomAskerService.new.go      
    assert_equal(true, res.is_a?(Asker))
  end
  test '.go Should some fields of an asker as non-empty' do
    asker = RandomAskerService.new.go      
    assert_not_equal(nil, asker.v_cadre)
    assert_not_equal(nil, asker.v_category)
  end
  test '.full Should return an Asker' do
    res = RandomAskerService.new.full      
    assert_equal(true, res.is_a?(Asker))
  end
  test '.full Should some fields of an asker as non-empty' do
    asker = RandomAskerService.new.full      
    asker_attributes_values = asker.attributes.values
    no_attribute_is_left_empty = asker_attributes_values.all? { |e| !e.blank? }
    assert_equal(true, no_attribute_is_left_empty)
  end
end
