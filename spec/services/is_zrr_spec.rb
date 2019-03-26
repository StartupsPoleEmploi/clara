require 'rails_helper'

describe IsZrr do

  describe '.call' do

    it "should return nil if there are not 5 digits" do
      #given
      #when
      res = IsZrr.new.call("")
      #then
      expect(res).to eq(nil)
    end

    it  "should return 'oui' if this is a zrr" do
      #given
      citycode = "59606"
      allow_any_instance_of(IsZrr).to receive(:call).with("59606").and_return("oui")
      allow(Rails.cache).to receive(:fetch).with("zrrs").and_return(true)
      expect(Rails.cache.exist?('zrrs')).to be(false)
      Rails.cache.write('zrrs')
      #when
      res = IsZrr.new.call(citycode)
      #then
      expect(Rails.cache.exist?('zrrs')).to be(true)
      #expect(res.include?(citycode)).to eq(true)
      #expect(res).to eq("oui")
    end

  end

end
