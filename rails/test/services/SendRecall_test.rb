require "test_helper"

class SendRecallTest < ActiveSupport::TestCase

  test "._time_to_send_email? returns false if current time is not between given range" do
    _fake_delta_with(0)
    faked_now = DateTime.now.change(hour: 12, min: 5)
    faked_lo = '8h30'
    faked_hi = '9h30'
    res = SendRecall.new._time_to_send_email?(faked_now, faked_lo, faked_hi)
    assert_equal(false, res)
  end
  test "._time_to_send_email? returns true if delta is correctly set" do
    _fake_delta_with(-3)
    faked_now = DateTime.now.change(hour: 12, min: 5)
    faked_lo = '8h30'
    faked_hi = '9h30'
    res = SendRecall.new._time_to_send_email?(faked_now, faked_lo, faked_hi)
    assert_equal(true, res)
  end

  test "._time_to_send_email? returns true if current time is between given range" do
    _fake_delta_with(0)
    faked_now = DateTime.now.change(hour: 9, min: 5)
    faked_lo = '8h30'
    faked_hi = '9h30'
    res = SendRecall.new._time_to_send_email?(faked_now, faked_lo, faked_hi)
    assert_equal(true, res)
  end
  test "._time_to_send_email? returns false if delta makes it out of range" do
    _fake_delta_with(6)
    faked_now = DateTime.now.change(hour: 9, min: 5)
    faked_lo = '8h30'
    faked_hi = '9h30'
    res = SendRecall.new._time_to_send_email?(faked_now, faked_lo, faked_hi)
    assert_equal(false, res)
  end
  test "._time_to_send_email? without stubs, it returns a boolean anyway" do
    _fake_delta_with(3)
    res = SendRecall.new._time_to_send_email?
    res_is_boolean = (res == true) || (res == false)
    assert_equal(true, res_is_boolean)
  end

  def _fake_delta_with(value)
    allow(Clockdiff).to receive(:first).and_return(OpenStruct.new(value: value))
  end
end
