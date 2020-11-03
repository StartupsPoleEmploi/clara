require "test_helper"

class CookiePreferenceTest < ActiveSupport::TestCase

    test 'By default, no preferences are set' do
      #given
      session = {}
      #when
      res = CookiePreference.new(session).cookie_preference_already_defined?
      #then
      assert_equal false, res
    end
    test 'GA is enabled by default' do
      #given
      session = {}
      #when
      res = !!CookiePreference.new(session).ga_disabled?
      #then
      assert_equal false, res
    end
    test 'GA can be disabled' do
      #given
      session = {}
      sut = CookiePreference.new(session)
      sut.set_preference({"analytics" => "forbid_statistic"})
      #when
      res = !!sut.ga_disabled?
      #then
      assert_equal true, res
    end
    test 'Returns authorization for statistic and navigation' do
      #given
      session = {}
      #when 
      cookie_preference = CookiePreference.new(session).accept_all_cookies
      #then
      assert_equal cookie_preference.symbolize_keys, {
        analytics: "authorize_statistic",
      }
    end

end
