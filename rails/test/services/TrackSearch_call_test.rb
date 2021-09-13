require "test_helper"

class TrackSearchCallTest < ActiveSupport::TestCase


  test ".call nominal" do
    #given
    expect(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_COLLECT").twice.and_return("ccc")
    expect(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_ID").and_return("iii")
    expect(URI).to receive(:parse).with("ccc").and_return("uuu")
    expect(SecureRandom).to receive(:hex).and_return("rrr")
    expect(Net::HTTP).to receive(:post_form)
      .with("uuu", 
        {"v" => "1", 
          "tid" => "iii", 
          "uid" => "rrr", 
          "t" => "event", 
          "ec" => "aids", 
          "ea" => "search", 
          "el" => "my search"})
      .and_return("call_ok")

    #when
    res = TrackSearch.new.call("my search")

    #then
    assert_equal("call_ok", res)
  end

  test "tracking not called when search is not a string" do
    #given
    #when
    res = TrackSearch.new.call(42)
    #then
    assert_equal("not called", res)
  end

  test "tracking not called when search is an empty string" do
    #given
    #when
    res = TrackSearch.new.call("")
    #then
    assert_equal("not called", res)
  end

  test "tracking not called when ARA_GOOGLE_ANALYTICS_COLLECT is not defined" do
    #given
    expect(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_COLLECT").and_return(nil)
    #when
    res = TrackSearch.new.call("my search")
    #then
    assert_equal("not called", res)
  end

end
