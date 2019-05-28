require "test_helper"

class IsZrrCallTest < ActiveSupport::TestCase
  

  test ".call nominal, found a ZRR => oui" do
    #given
    f = mock('object');f.expects(:fetch).with("zrrs").yields
    Rails.expects(:cache).returns(f)
    v = mock('object');v.expects(:value).returns("44220,43000")
    Zrr.expects(:first).returns(v)
    Zrr.expects(:first).returns(v)
    #when
    res = IsZrr.new.call("44220")
    #then
    assert_equal("oui", res)
  end

  test ".call nominal, found a ZRR with number => oui" do
    #given
    f = mock('object');f.expects(:fetch).with("zrrs").yields
    Rails.expects(:cache).returns(f)
    v = mock('object');v.expects(:value).returns("44220,43000,52202")
    Zrr.expects(:first).returns(v)
    Zrr.expects(:first).returns(v)
    #when
    res = IsZrr.new.call(43000)
    #then
    assert_equal("oui", res)
  end

  test ".call, didn't found a ZRR amongst existing => non" do
    #given
    f = mock('object');f.expects(:fetch).with("zrrs").yields
    Rails.expects(:cache).returns(f)
    v = mock('object');v.expects(:value).returns("69320,55320")
    Zrr.expects(:first).returns(v)
    Zrr.expects(:first).returns(v)
    #when
    res = IsZrr.new.call("44220")
    #then
    assert_equal("non", res)
  end

  test ".call, ZRR wasnt setupped => non" do
    #given
    f = mock('object');f.expects(:fetch).with("zrrs").yields
    Rails.expects(:cache).returns(f)
    Zrr.expects(:first).returns(nil)
    #when
    res = IsZrr.new.call("44220")
    #then
    assert_equal("non", res)
  end

  test ".call, do not have 5 digits => nil" do
    #given
    #when
    res = IsZrr.new.call(893)
    #then
    assert_nil(res)
  end

  test ".call, wrong type => nil" do
    #given
    #when
    res = IsZrr.new.call([])
    #then
    assert_nil(res)
  end

end
