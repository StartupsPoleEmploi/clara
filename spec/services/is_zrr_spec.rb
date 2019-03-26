require 'rails_helper'

describe IsZrr do

  describe '.call' do

    it "should return nul if there are not 5 digits" do
      #given
      #when
      res = IsZrr.new.call("")
      #then
      expect(res).to eq(nil)
    end

  end

end
