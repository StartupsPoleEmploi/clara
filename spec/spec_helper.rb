require 'webmock/rspec'
require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|

  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
