require 'rails_helper'

describe CalculateAskerService do
  describe '.calculate_zrr' do
    it 'Should calculate zrr' do
      # given
      # when
      CalculateAskerService.new.calculate_zrr!
      # then
      expect(asker.v_zrr).to eq()

    end
  end
end
