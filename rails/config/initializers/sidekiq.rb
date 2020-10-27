require 'sidekiq/web'
Sidekiq::Web.set :sessions, false

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://claredis:6379/1') }
end
Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://claredis:6379/1') }
end

