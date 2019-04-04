require 'rails_helper'

describe CookiePreference do

  describe '.accept_all_cookies' do
    it 'Returns authorization for statistic and navigation' do
      #given
      session = {"empty" => "hash"}
      #when
      #then
      expect(session.accept_all_cookies).to eq({"analytics" => "authorize_statistic","hotjar" => "authorize_navigation"})
    end
  end
end
