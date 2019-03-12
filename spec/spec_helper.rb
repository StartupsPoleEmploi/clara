require 'webmock/rspec'
require 'simplecov'

# Coverage
SimpleCov.start do
  add_filter "/spec/"
end
Rails.application.eager_load!

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|

  config.filter_run_when_matching :focus
  config.run_all_when_everything_filtered = true
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end


RSpec::Matchers.define :print_eq do |expected, msg|
  match do |actual|
    res = actual == expected
    args = Hash[ ARGV.flat_map{|s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) } ]

    if res
      ap "-- " + msg, color: {string: :green} unless args.key?('format')
    else
      ap "-- " + msg, color: {string: :red} unless args.key?('format')
    end
    res
  end
end



