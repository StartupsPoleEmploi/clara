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
      allow(Rails.cache).to receive(:fetch).with("zrrs").and_return(citycode)
      Rails.cache.write('zrrs', 'test')
      #when
      res = IsZrr.new.call(citycode)
      all_zrr = Rails.cache.fetch("zrrs")
      #then
      expect(all_zrr.include?(citycode)).to eq(true)
      expect(res).to eq("oui")
    end

    it  "should return 'non' if this is not a zrr" do
      #given
      citycode = "59606"
      allow_any_instance_of(IsZrr).to receive(:call).with("59606").and_return("non")
      allow(Rails.cache).to receive(:fetch).with("zrrs").and_return(" ")
      Rails.cache.write('zrrs', 'test')
      #when
      res = IsZrr.new.call(citycode)
      all_zrr = Rails.cache.fetch("zrrs")
      #then
      expect(all_zrr.include?(citycode)).to eq(false)
      expect(res).to eq("non")
    end

  end

end
