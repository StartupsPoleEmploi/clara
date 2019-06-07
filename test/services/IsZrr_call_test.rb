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
  test "Call without 5 digit is not allowed" do
    #given
    is_zrr = IsZrr.new
    #when
    #then
    assert_nil(is_zrr.call(nil))
    assert_nil(is_zrr.call(1234))
    assert_nil(is_zrr.call(12345.0))
    assert_nil(is_zrr.call([1,2,3,4]))
    assert_nil(is_zrr.call({}))
    assert_nil(is_zrr.call(""))
    assert_nil(is_zrr.call("5"))
    assert_nil(is_zrr.call("1234"))
    assert_nil(is_zrr.call("abcde"))
  end

end
