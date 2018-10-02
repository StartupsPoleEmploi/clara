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
 
# See https://stackoverflow.com/a/18266402/2595513
# See https://github.com/spree/spree/blob/master/core/lib/spree/testing_support/capybara_ext.rb#L148-L161
RSpec::Matchers.define :have_meta do |name, expected|
  match do |_actual|
    has_css?("meta[name='#{name}'][content='#{expected}']", visible: false)
  end

  failure_message do |actual|
    actual = first("meta[name='#{name}']")
    if actual
      "expected that meta #{name} would have content='#{expected}' but was '#{actual[:content]}'"
    else
      "expected that meta #{name} would exist with content='#{expected}'"
    end
  end
end
