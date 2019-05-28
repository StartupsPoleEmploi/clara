ENV['RAILS_ENV'] ||= 'test'

# Coverage, may slow down suite
require 'simplecov'
SimpleCov.start do
  add_filter %r{^/test/}
end

require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
