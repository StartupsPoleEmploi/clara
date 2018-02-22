require 'rails_helper'

describe CacheService do
  
  describe "Expiration time" do
    it '10 minutes allowed' do
      CacheService.set_instance(nil)
      expect(CacheService.get_instance.expire_time).to eq(10.minutes)
    end
  end

  describe "For testing purpose" do
    before(:each) do
      cache_layer = instance_double("CacheService")
      allow(cache_layer).to receive(:read).and_return("unexisting_read_value")
      allow(cache_layer).to receive(:write).and_return("unexisting_write_value")
      CacheService.set_instance(cache_layer)
    end
    after(:each) do
      CacheService.set_instance(nil)
    end
    it 'READ Can be stubbed easily' do
      sut = CacheService.get_instance
      output = sut.read('id')
      expect(output).to eq('unexisting_read_value')
    end
    it 'WRITE Can be stubbed easily' do
      sut = CacheService.get_instance
      output = sut.write('id', 'thing')
      expect(output).to eq('unexisting_write_value')
    end
  end

end
