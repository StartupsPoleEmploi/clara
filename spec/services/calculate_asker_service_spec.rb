require 'rails_helper'

describe CalculateAskerService do
  describe '.calculate_zrr' do
    it 'Should calculate zrr' do
      # given
      asker = Asker.new
      asker.v_location_citycode = "20245"
      # when
      CalculateAskerService.new(asker).calculate_zrr!
      # then
      expect(asker.v_zrr).to eq("oui")

    end
  end
end
