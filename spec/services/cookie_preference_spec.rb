require 'rails_helper'

describe CookiePreference do
  describe '.accept_all_cookies' do
    it 'By default, no preferences are set' do
      #given
      session = {}
      #when
      res = CookiePreference.new(session).cookie_preference_already_defined?
      #then
      expect(res).to eq(false)
    end
    it 'GA is enabled by default' do
      #given
      session = {}
      #when
      res = !!CookiePreference.new(session).ga_disabled?
      #then
      expect(res).to eq(false)
    end
    it 'HJ is enabled by default' do
      #given
      session = {}
      #when
      res = !!CookiePreference.new(session).hj_disabled?
      #then
      expect(res).to eq(false)
    end
    it 'GA can be disabled' do
      #given
      session = {}
      sut = CookiePreference.new(session)
      sut.set_preference({"analytics" => "forbid_statistic"})
      #when
      res = !!sut.ga_disabled?
      #then
      expect(res).to eq(true)
    end
    it 'HJ can be disabled' do
      #given
      session = {}
      sut = CookiePreference.new(session)
      sut.set_preference({"hotjar" => "forbid_navigation"})
      #when
      res = !!sut.hj_disabled?
      #then
      expect(res).to eq(true)
    end
    it 'Returns authorization for statistic and navigation' do
      #given
      session = {}
      #when 
      cookie_preference = CookiePreference.new(session).accept_all_cookies
      #then
      expect(cookie_preference.symbolize_keys).to eq({
        analytics: "authorize_statistic",
        hotjar: "authorize_navigation"
      })
    end
  end
end
