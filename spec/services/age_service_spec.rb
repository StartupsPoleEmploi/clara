require 'rails_helper'

describe AgeService do

  describe '.new_and_download' do
    it 'Returns a new age form with age_type filled from given asker' do
      #given
      asker = Asker.new
      asker.v_age = '16'
      #when
      result = AgeService.new.new_and_download(asker)
      #then
      expect(result.number_of_years).to eq('16')
    end
  end

#  describe '.upload' do
#    it 'should inject allocation_type into asker' do
#    end
#  end
end
