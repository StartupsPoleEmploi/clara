require 'rails_helper'

RSpec.describe "Cookies", type: :request do
  describe "GET /cookies" do
    it "works! (now write some real specs)" do
      get cookies_path
      expect(response).to have_http_status(200)
    end
  end
end
