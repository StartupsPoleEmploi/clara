require 'raven'

# :nocov:
unless Rails.env.test?
  if ENV['ARA_DSN_SENTRY']
    Raven.configure do |config|
      config.current_environment = Rails.env
      config.environments = ['development', 'staging', 'production']
      config.ssl_verification = false
      config.dsn = ENV['ARA_DSN_SENTRY']
    end
  end
end
# :nocov:
