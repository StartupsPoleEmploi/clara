ENV['RAILS_ENV'] ||= 'test'

require 'rspec/mocks/minitest_integration'
require 'webmock/minitest'

# Coverage, may slow down suite
require 'simplecov'
SimpleCov.start 'rails' do
  coverage_dir "coverage/ruby/unit".to_s
  add_filter "app/jobs/application_job.rb"
  add_filter "bin/spring"
  add_filter "app/services/pe_connect_service.rb"
  add_filter "app/channels/application_cable/channel.rb"
  add_filter "app/channels/application_cable/connection.rb"
  add_filter "app/services/fake_connection.rb"
end

require_relative '../config/environment'
require 'rails/test_help'

WebMock.disable_net_connect!(allow_localhost: true)

def connect_as_superadmin
  user = User.create(email: "superadmin@clara.com", password: "bar", role: "superadmin")
  post session_url, params: { session: { email: user.email, password: user.password }}
end

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

  def text_of(selector)
    Nokogiri::HTML(response.body).css(selector).text
  end

  def fake(h)
    OpenStruct.new(h)
  end
end
