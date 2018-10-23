Mailjet.configure do |config|
  config.api_key = ENV['ARA_EMAIL_API_KEY']
  config.secret_key = ENV['ARA_EMAIL_SECRET_KEY']
  config.default_from = ENV['ARA_EMAIL_FROM']
end
