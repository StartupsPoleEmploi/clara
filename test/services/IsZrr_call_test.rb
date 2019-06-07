require "test_helper"

class IsZrrCallTest < ActiveSupport::TestCase
  

  test ".call nominal, found a ZRR in cache => oui" do
    allow(Rails.cache).to receive(:fetch).with("zrrs").and_return("73253,84069,59606,87079,87159,88033,88093,88419\r\n")
    res = IsZrr.new.call("59606")
    assert_equal("oui", res)
  end
  test ".call nominal, found a ZRR in cache with number => oui" do
    allow(Rails.cache).to receive(:fetch).with("zrrs").and_return("73253,84069,59606,87079,87159,88033,88093,88419\r\n")
    res = IsZrr.new.call(59606)
    assert_equal("oui", res)
  end
  test ".call, didn't found a ZRR in cache amongst existing => non" do
    allow(Rails.cache).to receive(:fetch).with("zrrs").and_return("73253,84069,59606,87079,87159,88033,88093,88419\r\n")
    res = IsZrr.new.call(44220)
    assert_equal("non", res)
  end
  test ".call nominal, found a ZRR in DB => oui" do
    allow(Zrr).to receive(:first).and_return(OpenStruct.new(:value => "73253,84069,59606,87079,87159,88033,88093,88419\r\n"))
    res = IsZrr.new.call("59606")
    assert_equal("oui", res)
  end
  test ".call nominal, found a ZRR in DB with number => oui" do
    allow(Zrr).to receive(:first).and_return(OpenStruct.new(:value => "73253,84069,59606,87079,87159,88033,88093,88419\r\n"))
    res = IsZrr.new.call(59606)
    assert_equal("oui", res)
  end
  test ".call nominal, didnt found a ZRR in DB with number => non" do
    allow(Zrr).to receive(:first).and_return(OpenStruct.new(:value => "73253,84069,59606,87079,87159,88033,88093,88419\r\n"))
    res = IsZrr.new.call(44220)
    assert_equal("non", res)
  end

  # test ".call, didn't found a ZRR amongst existing => non" do
  #   #given
  #   f = mock('object');f.expects(:fetch).with("zrrs").yields
  #   Rails.expects(:cache).returns(f)
  #   v = mock('object');v.expects(:value).returns("69320,55320")
  #   Zrr.expects(:first).returns(v)
  #   Zrr.expects(:first).returns(v)
  #   #when
  #   res = IsZrr.new.call("44220")
  #   #then
  #   assert_equal("non", res)
  # end

  # test ".call, ZRR wasnt setupped => non" do
  #   #given
  #   f = mock('object');f.expects(:fetch).with("zrrs").yields
  #   Rails.expects(:cache).returns(f)
  #   Zrr.expects(:first).returns(nil)
  #   #when
  #   res = IsZrr.new.call("44220")
  #   #then
  #   assert_equal("non", res)
  # end

  # test ".call, do not have 5 digits => nil" do
  #   #given
  #   #when
  #   res = IsZrr.new.call(893)
  #   #then
  #   assert_nil(res)
  # end

  # test ".call, wrong type => nil" do
  #   #given
  #   #when
  #   res = IsZrr.new.call([])
  #   #then
  #   assert_nil(res)
  # end

end
