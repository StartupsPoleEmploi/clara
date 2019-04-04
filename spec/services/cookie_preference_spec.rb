require 'rails_helper'

describe CookiePreference do

  describe '.accept_all_cookies' do
    it 'Returns authorization for statistic and navigation' do
      #given
      session = {}
      #allow_any_instance_of(CookiePreference).to receive(:accept_all_cookies).and_return({"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"})
      #when
      session = CookiePreference.new.accept_all_cookies
      #res = session[:cookie].accept_all_cookies
      #then
      expect(session).to eq({"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"})
    end
  end
end
