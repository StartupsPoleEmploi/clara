require 'rails_helper'

describe CalculateAskerService do

  describe '.calculate_zrr' do
    it 'Should calculate zrr' do
      # given
      calculate_zrr_service = instance_double('CalculateAskerService')
      asker = Asker.new
      asker.v_location_citycode = "20245"
      asker.v_zrr = IsZrr.new.call("20245")
      # when
      asker = CalculateAskerService.new(asker).calculate_zrr!
      # then
      expect(asker.v_zrr).to eq("oui")

    end
  end


end
