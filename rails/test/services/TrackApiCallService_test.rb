require "test_helper"

class TrackApiCallServiceTest < ActiveSupport::TestCase
  
  test '._tracked return given arg if it is a string' do
    #given
    given_arg = "a String"
    #when
    result = TrackApiCallService.new._tracked(given_arg)
    #then
    assert_equal(given_arg, result)
  end
  test '._tracked do not return given arg if it ISNT a string' do
    #given
    given_arg = 42
    #when
    result = TrackApiCallService.new._tracked(given_arg)
    #then
    assert_not_equal(given_arg, result)
  end
  test '._tracked returns user_not_found@clara.com if input is nil' do
    #given
    given_arg = nil
    #when
    result = TrackApiCallService.new._tracked(given_arg)
    #then
    assert_equal("user_not_found@clara.com", result)
  end
end
