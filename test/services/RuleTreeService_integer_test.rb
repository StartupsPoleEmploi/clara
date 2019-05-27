require "test_helper"

class RuleTreeServiceIntegerTest < ActiveSupport::TestCase

  
  test ".calculate integer, 18, more_than, 16 => true" do
    #given
    sut = RuletreeService.new
    #when
    res = sut.send :calculate, "34", "more_than", "18", "integer", ""
    #then
    assert_equal(true, res)
  end


end
