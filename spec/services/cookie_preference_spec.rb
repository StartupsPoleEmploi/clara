require 'rails_helper'

describe CookiePreference do

  describe '.accept_all_cookies' do
    it 'Returns authorization for statistic and navigation' do
      #given
      request.cookies['foo'] = 'bar'
      get :accept_all_cookies
      #when
      #then
      expect(response.cookies['foo']]).accept_all_cookies).to eq({"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"})
    end
  end
end
