require 'rails_helper'

describe CalculateAskerService do

  describe '.calculate_zrr!' do

    it "should update v_zrr of an asker" do |variable|
      #given
      asker = Asker.new
      expect(asker.v_zrr).to eq(nil)
      #when
      #then
      # res = CalculateAskerService.new(Asker.new).calculate_zrr!
      # expect(res).to eq("blabla")      
    end

  end

end
