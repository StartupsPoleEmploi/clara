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
      #when
      #then
      expect(res).to eq("oui")
    end
  end

end
