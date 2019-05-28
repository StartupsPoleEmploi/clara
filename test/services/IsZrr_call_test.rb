require "test_helper"

class IsZrrCallTest < ActiveSupport::TestCase
  

  test ".call nominal" do
    #given
    f = mock('object')
    f.expects(:fetch).with("zrrs").yields{return "44220"}
    Rails.expects(:cache).returns(f)
    v = mock('object')
    v.expects(:value).returns("44220,43000")
    Zrr.expects(:first).returns(v)
    Zrr.expects(:first).returns(v)
    #when
    res = IsZrr.new.call("44220")
    #then
    assert_equal("call_ok", res)
  end

end
