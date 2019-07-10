ENV['RAILS_ENV'] ||= 'test'

require 'rspec/mocks/minitest_integration'

# Coverage, may slow down suite
require 'simplecov'
SimpleCov.start do
  add_filter %r{^/test/}
  add_filter "/models/"
  track_files '{app/services,app/view_objects}/*.rb'
end

require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
