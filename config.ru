# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

if Rails.env.development? || Rails.env.production?
  use Rack::RubyProf, :path => './public/profile'
end

run Rails.application
