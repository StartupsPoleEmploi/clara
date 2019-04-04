require 'rails_helper'

describe CookiePreference do

  describe '.accept_all_cookies' do
    it 'Returns authorization for statistic and navigation' do
      #given
      #when 
      cookie_preference = CookiePreference.new(session).accept_all_cookies
      #then
      expect(cookie_preference).to eq({"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"})
    end
  end
end
