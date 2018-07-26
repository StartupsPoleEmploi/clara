# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# Only if you have to hard-profile
if ENV['ARA_PROFILING']
  use Rack::RubyProf, :path => './public/profile'
end

run Rails.application
