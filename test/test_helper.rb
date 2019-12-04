ENV['RAILS_ENV'] ||= 'test'

require 'rspec/mocks/minitest_integration'

# Coverage, may slow down suite
require 'simplecov'
SimpleCov.start do
  add_filter %r{^/test/}
  add_filter "/models/"
  track_files '{app/services,app/view_objects}/*.rb'
  coverage_dir "coverage/ruby/unit".to_s
end

require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def ascending? (array)
    yes = true
    array.reduce { |l, r| break unless yes &= (l[0] <= r[0]); l }
    yes
  end

  def same_array?(a, b)
    !a.difference(b).any?
  end
end
