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

  describe '.ga_disabled?'
    it 'Returns true if ga is disabled' do
      #given
      #when
      #then
    end
  end

  end
end
