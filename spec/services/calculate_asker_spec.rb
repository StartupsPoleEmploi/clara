require 'rails_helper'

describe CalculateAskerService do

  describe '.calculate_zrr!' do

    it "should update v_zrr of an asker" do |variable|
      #given
      asker = Asker.new
      expect(asker.v_zrr).to eq(nil)
      allow_any_instance_of(IsZrr).to receive(:call).and_return("trucmuche")
      #when
      CalculateAskerService.new(asker).calculate_zrr!
      #then
      expect(asker.v_zrr).not_to eq(nil)
    end

  end

end
