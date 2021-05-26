# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :active_record_store, key: 'clara'

if Rails.env.test?
  Rails.application.config.session_store :cookie_store, key: 'clara_test_session', expire_after: 24.hours
else
  Rails.application.config.session_store :redis_session_store, {
    key: 'clara_actual_session',
    secure: Rails.env.production?,
    redis: {
      expire_after: 120.minutes,  # cookie expiration
      ttl: 120.minutes,           # Redis expiration, defaults to 'expire_after'
      key_prefix: 'clarapp:session:',
      url: ENV['REDIS_URL'],
    }
  }
end

# Rails.application.config.session_store :cookie_store, key: 'hide_convention', expire_after: 24.hours
