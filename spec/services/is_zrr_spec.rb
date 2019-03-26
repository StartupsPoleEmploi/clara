require 'rails_helper'

describe IsZrr do

  describe '.call' do

    it "should return nil if there are not 5 digits" do
      #given
      is_zrr = IsZrr.new
      #when
      #then
      expect(is_zrr.call(nil)).to eq(nil)
      expect(is_zrr.call(1234)).to eq(nil)
      expect(is_zrr.call(12345.0)).to eq(nil)
      expect(is_zrr.call([1,2,3,4])).to eq(nil)
      expect(is_zrr.call({})).to eq(nil)
      expect(is_zrr.call("")).to eq(nil)
      expect(is_zrr.call("5")).to eq(nil)
      expect(is_zrr.call("1234")).to eq(nil)
      expect(is_zrr.call("abcde")).to eq(nil)
    end

    it  "should return 'oui' if this is a zrr in the cache" do
      #given
      allow(Rails.cache).to receive(:fetch).with("zrrs").and_return("73253,84069,59606,87079,87159,88033,88093,88419\r\n")
      #when
      #then
      expect(IsZrr.new.call(59606)).to eq("oui")
      expect(IsZrr.new.call("59606")).to eq("oui")
    end

    it  "should return 'oui' if this is no zrr in the cache, but in database" do
      #given
      #when
      allow(Zrr).to receive(:first).and_return(OpenStruct.new(:value => "73253,84069,59606,87079,87159,88033,88093,88419\r\n"))
      #then
      expect(IsZrr.new.call("59606")).to eq("oui")
    end

    it  "should return 'non' if this is no zrr in the cache, but in database, but value not here" do
      #given
      #when
      allow(Zrr).to receive(:first).and_return(OpenStruct.new(:value => "73253,84069,87079,87159,88033,88093,88419\r\n"))
      #then
      expect(IsZrr.new.call("59606")).to eq("non")
    end

    it  "should return 'non' if this is no zrr in the cache, and db is empty" do
      #given
      #when
      allow(Zrr).to receive(:first).and_return(nil)
      #then
      expect(IsZrr.new.call("59606")).to eq("non")
    end


  end

end
