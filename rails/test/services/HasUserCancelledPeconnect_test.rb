require "test_helper"

class HasUserCancelledPeconnectTest < ActiveSupport::TestCase

  test ".call returns true if there is only one query parameter, and this param is 'state'" do
    #given
    original_url = 'myurl.com?state=any'
    #when
    res = HasUserCancelledPeconnect.new.call(original_url)
    #then
    assert_equal true, res
  end

  test ".call returns false if there is only one query parameter, and this param is not 'state'" do
    #given
    original_url = 'myurl.com?code=any'
    #when
    res = HasUserCancelledPeconnect.new.call(original_url)
    #then
    assert_equal false, res
  end

  test ".call returns false if there is more than one query parameter" do
    #given
    original_url = 'myurl.com?state=42&code=any'
    #when
    res = HasUserCancelledPeconnect.new.call(original_url)
    #then
    assert_equal false, res
  end

end
