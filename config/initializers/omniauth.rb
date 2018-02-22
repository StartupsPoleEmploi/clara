Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['ARA_GOOGLE_CLIENT_ID'], ENV['ARA_GOOGLE_CLIENT_SECRET']
end
