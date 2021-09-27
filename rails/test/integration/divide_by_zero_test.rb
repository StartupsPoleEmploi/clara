require 'test_helper'

class DivideByZeroTest < ActionDispatch::IntegrationTest

  test "generate an exception to check logging, events, and so on..." do
    assert_raises ZeroDivisionError do
      #when
      get divide_by_zero_index_path
    end
  end


end
