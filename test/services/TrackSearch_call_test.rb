require "test_helper"

class TrackSearchCallTest < ActiveSupport::TestCase
  

  test ".call nominal" do
    #given
    ENV.expects(:[]).with("ARA_GOOGLE_ANALYTICS_COLLECT").returns("ccc")
    ENV.expects(:[]).with("ARA_GOOGLE_ANALYTICS_ID").returns("iii")
    URI.expects(:parse).with("ccc").returns("uuu")
    SecureRandom.expects(:hex).returns("rrr")
    Net::HTTP
      .expects(:post_form)
      .with("uuu", 
              {"v" => "1", 
                "tid" => "iii", 
                "uid" => "rrr", 
                "t" => "event", 
                "ec" => "aids", 
                "ea" => "search", 
                "el" => "my search"})
      .returns("call_ok")

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

end
