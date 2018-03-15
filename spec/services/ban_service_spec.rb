require 'rails_helper'
require 'uri'

describe BanService do 

  http_layer = nil
  env_layer = nil

  describe "For testing purpose" do
    before do
      ban_layer = instance_double("BanService")
      allow(ban_layer).to receive(:get_zipcode_and_cityname).and_return("faked_value")
      BanService.set_instance(ban_layer)
    end
    after do
      BanService.set_instance(nil)
    end
    it '.get_zipcode_and_cityname Can be stubbed easily' do
      sut = BanService.get_instance
      output = sut.get_zipcode_and_cityname('59035')
      expect(output).to eq("faked_value")
    end
  end
  describe '.get_zipcode_and_cityname' do
    describe '59035 Lille' do
      before(:each) do
        env_layer = instance_double("EnvService")
        allow(env_layer).to receive(:ara_url_ban).and_return("https://url_of_ban?q=")
        EnvService.set_instance(env_layer)
      end
      after(:each) do
        EnvService.set_instance(nil)
        HttpService.set_instance(nil)
      end

      it 'External service should be called with the right url ' do
        # given
        http_layer = spy('HttpService')
        HttpService.set_instance(http_layer)
        # when
        BanService.get_instance.get_zipcode_and_cityname('59035')
        # then
        expect(http_layer).to have_received(:get).with URI.parse('https://url_of_ban?q=rue&citycode=59035') 
      end
      # it 'Should return "59035" and "Lille"' do
      #   http_layer = instance_double("HttpService")
      #   allow(http_layer).to receive(:get).and_return('{"id":"29123"}')
      #   HttpService.set_instance(http_layer)
      #   expect(BanService.get_instance.isZRR('29123')).to eq 'en_ban'
      # end
    end
    


  end
end
