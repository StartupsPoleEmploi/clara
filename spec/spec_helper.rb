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
    mocks.verify_partial_doubles = false
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end


RSpec::Matchers.define :print_eq do |expected, msg|
  match do |actual|
    res = actual == expected
    if res
      ap "-- " + msg, color: {string: :green}
    else
      ap "-- " + msg, color: {string: :red}
    end
    res
  end
end


class Recorder
  def self.initialize
    @@data = []
    return Recorder.new
  end

  def record(expect, data, description)
    @@data << { :pass => true,  :expect => expect, :value => data, :description => description }
    self
  end

  def record_error(expect, data, failure_message, description)
    @@data << { :pass => false, :expect => expect, :value => data, :message => failure_message,  :description => description }
    self
  end

  def self.data
    @@data ||= []
  end

  def expect(object, value, description = "")
    return ExpectWrapper.new(object.expect(value), self, description)
  end
end

class ExpectWrapper
  def initialize(_expect, _recorder, _description)
    @expect = _expect
    @recorder = _recorder
    @description = _description
    p '- - - - - - - - - - - - - - @description- - - - - - - - - - - - - - - -' 
    pp @description
    p ''
  end

  def to(matcher, failure_message=nil)
    begin
      expect_ret = @expect.to(matcher, failure_message) # test

      # for tests that aggregate failures
      if expect_ret.instance_of?(TrueClass)
        @recorder.record(matcher.actual, matcher.description, @description)
      else
        @recorder.record_error(matcher.actual, matcher.description, failure_message, @description)
      end
      expect_ret
    rescue RSpec::Expectations::ExpectationNotMetError => e
      # for test that do not aggregate failures
      @recorder.record_error(matcher.actual, matcher.description, failure_message, @description)
      raise e
    end

  end
end
