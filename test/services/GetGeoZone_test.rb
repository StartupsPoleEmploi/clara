require "test_helper"

class GetGeoZoneTest < ActiveSupport::TestCase
  
  test '.call should return "Toute la France" by default' do
    #given
    sut = GetGeoZone.new
    #when
    res = sut.call(nil)
    #then
    assert_equal("Toute la France", res)

  end

end
