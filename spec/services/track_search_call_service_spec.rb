require 'rails_helper'

describe TrackSearch do

  describe 'Can post to analytics endpoint with one keyword' do
    it 'With keyword "aid"' do
      # given
      allow(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_COLLECT").and_return("analytics_collect")
      allow(ENV).to receive(:[]).with("ARA_GOOGLE_ANALYTICS_ID").and_return("analytics_id")
      http_layer = _allow_http_layer(
        with_action: :post_form, 
        with_url: URI.parse("analytics_collect"), 
        with_params:{
          "ea"=>"aid", 
          "ec"=>"search", 
          "t"=>"event", 
          "tid" => "analytics_id", 
          "v" => "1"})
      # when
      res = TrackSearch.call(keywords: "aid")
      # then
      expect(res).to eq("ok")   
      # http_layer.should_receive(:post_form).exactly(1).times

    end
    it 'With keyword "help"' do
      # given
      # when
      # then   
    end
  end
  describe 'Can post to analytics endpoint with multiples keywords' do
    it 'With keywords "aid social"' do
      # given
      # when
      # then   
    end
    it 'With keywords "help aid active"' do
      # given
      # when
      # then   
    end
  end
  describe 'Avoid call if there is anything wrong' do
    it 'With keywords " " (blank String)' do
      # given
      # when
      # then   
    end
    it 'With keywords Date (wrong type)' do
      # given
      # when
      # then   
    end
  end

  def _allow_http_layer(arg_hash)
    http_layer = instance_double("HttpService")
    allow(http_layer).to receive(arg_hash[:with_action]).with(arg_hash[:with_url], hash_including(arg_hash[:with_params]))
    HttpService.set_instance(http_layer)
    http_layer
  end

end
