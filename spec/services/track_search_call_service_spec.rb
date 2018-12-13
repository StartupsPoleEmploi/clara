require 'rails_helper'

describe TrackSearch do

  describe 'Can post to analytics endpoint with one keyword' do
    it 'With keyword "aid"' do
      # given
      _setup_test_with(:ga_receive => "aid")
      # when
      res = TrackSearch.call(user_search: "aid")
      # then
      expect(res).to eq("test is ok")   

    end
    it 'With keyword "help"' do
      # given
      _setup_test_with(:ga_receive => "help")
      # when
      res = TrackSearch.call(user_search: "help")
      # then
      expect(res).to eq("test is ok")   
 
    end
  end
  describe 'Can post to analytics endpoint with multiples keywords' do
    it 'With keywords "aid social"' do
      # given
      _setup_test_with(:ga_receive => "aid social")
      # when
      res = TrackSearch.call(user_search: "aid social")
      # then   
      expect(res).to eq("test is ok")
    end
    it 'With keywords "help aid active"' do
      # given
      _setup_test_with(:ga_receive => "help aid active")
      # when
      res = TrackSearch.call(user_search: "help aid active")
      # then   
      expect(res).to eq("test is ok")
    end
  end
  describe 'Avoid call if there is anything wrong' do
    it 'With keywords " " (blank String)' do
      # given
      # when
      res = TrackSearch.call(user_search: "  ")
      # then   
      expect(res).to eq("not called")  
    end
    it 'With keywords Date (wrong type)' do
      # given
      # when
      res = TrackSearch.call(user_search: Date.new)
      # then   
      expect(res).to eq("not called")  
    end
  end

  def _setup_test_with(arg_hash)
    allow(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_COLLECT").and_return("analytics_collect")
    allow(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_ID").and_return("analytics_id")
    http_layer = _allow_http_layer(
      with_action: :post_form, 
      with_url: URI.parse("analytics_collect"), 
      with_params:{
        "v" => "1",
        "tid" => "analytics_id", 
        "uid" => kind_of(String), 
        "t"=>"event", 
        "ec"=>"search", 
        "ea"=>arg_hash[:ga_receive], 
      }
    )
  end

  def _allow_http_layer(arg_hash)
    http_layer = class_double("Net::HTTP").as_stubbed_const
    allow(http_layer).to ( 
      receive(arg_hash[:with_action])
      .with(arg_hash[:with_url], hash_including(arg_hash[:with_params]))
      .and_return("test is ok")
    )
    HttpService.set_instance(http_layer)
    http_layer
  end

end
