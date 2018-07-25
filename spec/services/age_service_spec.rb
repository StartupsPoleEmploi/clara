require 'rails_helper'

describe AgeService do
  describe '.new_and_download' do
    it 'Returns a new age form with age filled from given asker' do
      #given
      #when
      #then
      expect(result.class.to_i).to eq('AgeForm')
      expect(result.type).to eq(16)
    end
  end
end
