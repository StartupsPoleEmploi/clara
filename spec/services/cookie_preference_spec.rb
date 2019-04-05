require 'rails_helper'

describe CookiePreference do

  describe '.accept_all_cookies' do
    it 'Returns authorization for statistic and navigation' do
      #given
      session = {"my" => "hash"}
      #when 
      cookie_preference = CookiePreference.new(session).accept_all_cookies
      #then
      expect(cookie_preference).to eq({"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"})
    end
  end
  describe '.cookie_preference_already_defined?' do
    it 'Return true if cookie is different from nil' do
      #given
      res = false
      session = {"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"}
      #when
      res = CookiePreference.new(session).cookie_preference_already_defined?
      #then
      expect(res).to eq(true)
    end   
    # it 'Return false if cookie is nil' do
    #   #given
    #   res = true
    #   session
    #   #when
    #   res = CookiePreference.new(session).cookie_preference_already_defined?
    #   #then
    #   expect(res).to eq(false)
    # end   
  end
  describe '.ga_disabled?' do
    it 'Returns true if ga is disabled' do
      #given
      res = false
      session = {"analytics" => "forbid_statistic"}
      #when
      res = CookiePreference.new(session).ga_disabled?
      #then
      expect(res).to eq(true)
    end

    it 'Returns false if ga is disabled' do
      #given
      res = true
      session = {"analytics" => "authorize_statistic"}
      #when
      res = CookiePreference.new(session).ga_disabled?
      #then
      expect(res).to eq(false)
    end
  end
  describe '.set_preference' do
    it  'Return the cookie preference' do
      #given
      session = {"my" => "session"}
      preference = {"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"}
      #when
      session = CookiePreference.new(session).set_preference(preference) 
      #then
      expect(session).to eq(preference)
    end
  end
end
