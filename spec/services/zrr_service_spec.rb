require 'rails_helper'
require 'uri'

describe ZrrService do 

  http_layer = nil
  env_layer = nil

  describe "For testing purpose" do
    before do
      zrr_layer = instance_double("ZrrService")
      allow(zrr_layer).to receive(:isZRR).and_return("unexisting_zrr_value")
      ZrrService.set_instance(zrr_layer)
    end
    after do
      ZrrService.set_instance(nil)
    end
    it '.isZRR Can be stubbed easily' do
      sut = ZrrService.get_instance
      output = sut.isZRR('citycode')
      expect(output).to eq('unexisting_zrr_value')
    end
  end
  describe '.isZRR' do
    describe 'oui' do
      before(:each) do
        env_layer = instance_double("EnvService")
        allow(env_layer).to receive(:ara_url_qpvzrr).and_return("https://url_of_zrr")
        EnvService.set_instance(env_layer)
      end
      after(:each) do
        EnvService.set_instance(nil)
        HttpService.set_instance(nil)
      end

      it 'External service should be called with the right url ' do
        # given
        correct_uri  = URI.parse('https://url_of_zrr/zrr/zrrs/THE_ID')
        http_layer = spy('HttpService')
        HttpService.set_instance(http_layer)
        # when
        ZrrService.get_instance.isZRR('THE_ID')
        # then
        expect(http_layer).to have_received(:get).with correct_uri 
      end
      it 'Should return "en_zrr" if response include an id' do
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return('{"id":"29123"}')
        HttpService.set_instance(http_layer)
        expect(ZrrService.get_instance.isZRR('29123')).to eq 'en_zrr'
      end
    end
    describe 'wrong requirement' do
      before(:each) do
        env_layer = instance_double("EnvService")
        allow(env_layer).to receive(:ara_url_qpvzrr).and_return("https://url_of_zrr")
        EnvService.set_instance(env_layer)
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return('{"id":"29123"}')
        HttpService.set_instance(http_layer)
      end
      after(:each) do
        EnvService.set_instance(nil)
        HttpService.set_instance(nil)
      end

      it 'Should return "erreur_technique" if param is empty' do
        expect(ZrrService.get_instance.isZRR('')).to eq 'erreur_technique'
      end
      it 'Should return "erreur_technique" if param is not a string' do
        expect(ZrrService.get_instance.isZRR([1,2,3])).to eq 'erreur_technique'
      end
    end
    describe 'non' do
      before(:each) do
        env_layer = instance_double("EnvService")
        allow(env_layer).to receive(:ara_url_qpvzrr).and_return("https://url_of_zrr")
        EnvService.set_instance(env_layer)
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return('{}')
        HttpService.set_instance(http_layer)
      end
      after(:each) do
        EnvService.set_instance(nil)
        HttpService.set_instance(nil)
      end

      it 'Should return "hors_zrr" if response has no id' do
        expect(ZrrService.get_instance.isZRR('29123')).to eq 'hors_zrr'
      end
    end
    describe 'erreur' do
      before(:each) do
        env_layer = instance_double("EnvService")
        allow(env_layer).to receive(:ara_url_qpvzrr).and_return("https://url_of_zrr")
        EnvService.set_instance(env_layer)
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return('')
        HttpService.set_instance(http_layer)
      end
      after(:each) do
        EnvService.set_instance(nil)
        HttpService.set_instance(nil)
      end

      it 'Should return "erreur_communication" if response is empty' do
        expect(ZrrService.get_instance.isZRR('29123')).to eq 'erreur_communication'
      end
    end
    describe 'timeout' do
      before(:each) do
        env_layer = instance_double("EnvService")
        allow(env_layer).to receive(:ara_url_qpvzrr).and_return("https://url_of_zrr")
        EnvService.set_instance(env_layer)
        http_layer = instance_double("HttpService")
        allow(http_layer).to receive(:get).and_return('timeout')
        HttpService.set_instance(http_layer)
      end
      after(:each) do
        EnvService.set_instance(nil)
        HttpService.set_instance(nil)
      end

      it 'Should return "service_indisponible" if service timesout' do
        expect(ZrrService.get_instance.isZRR('29123')).to eq 'service_indisponible'
      end
    end
  end
end
