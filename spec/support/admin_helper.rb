module AdminHelper
  def sign_in
    sign_in_as("pouet@pouet.com")
  end

  def sign_in_as(email)
    ENV["ARA_AUTH_ADMIN_USERS"] = email
    OmniAuth.config.add_mock(:google_oauth2, {uid: '12345', info: {email: email}})
    visit admin_root_path
  end
end

RSpec.configure do |config|
  config.include AdminHelper, type: :feature
end
