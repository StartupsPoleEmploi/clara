class ExpectWrapper
  def initialize(_expect, _recorder, _description)
    @expect = _expect
    @recorder = _recorder
    @description = _description
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

class Recorder
  def self.start
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
    @@data
  end

  def expect(object, value, description = "")
    return ExpectWrapper.new(object.expect(value), self, description)
  end
end

class CustomFormatter
  RSpec::Core::Formatters.register self, :example_passed, :example_failed


  def initialize(output)
    @output = output
  end

  def example_passed(notification)
    @output.puts( format_output(notification.example, Recorder) )
  end

  def get_test_name( group, description)
    "#{group.example.example_group}/#{description}".gsub('RSpec::ExampleGroups::','')
  end

  def format_output( example, recorder )
    test_case = get_test_name( example.example_group, example.description)
    str = "**********TEST: #{test_case} ************\n"
    recorder.data.each do |d|
       str += sprintf("%s: ---> expected '%-10s' to '%-20s' DESC: %s \n",  d[:pass] ? 'PASS' : 'FAIL',  d[:expect], d[:value], d[:description])
    end
    str

  end

  def example_failed(notification)
    @output.puts(format_output( notification.example, Recorder))

    exception = notification.exception
    message_lines = notification.fully_formatted_lines(nil, RSpec::Core::Notifications::NullColorizer)
    exception_details = if exception
                          {
                              # drop 2 removes the description (regardless of newlines) and leading blank line
                              :message => message_lines.drop(2).join("\n"),
                              :backtrace => notification.formatted_backtrace.join("\n"),
                          }
                        end

     @output.puts RSpec::Core::Formatters::ConsoleCodes.wrap(exception_details[:message], :failure)

  end


end
