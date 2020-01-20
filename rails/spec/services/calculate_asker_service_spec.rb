require 'rails_helper'

describe CalculateAskerService do
  describe '.calculate_zrr!' do
    it 'should update zrr field' do
      #given
      asker = Asker.new
      asker.v_location_citycode = "59606"
      expect(asker.v_zrr).to eq(nil)
      allow_any_instance_of(IsZrr).to receive(:call).with("59606").and_return("est_en_zrr")
      #when
      CalculateAskerService.new(asker).calculate_zrr!
      #then
      expect(asker.v_zrr).to eq("est_en_zrr")
    end
  end
end
