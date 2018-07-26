require 'rails_helper'

describe ApiAskerService do
  describe '.to_asker' do
    it 'Should transform to asker' do
      #given
      #when
      #then
      expect(asker.v_spectacle).to eq('mySpectacle')
      expect(asker.v_handicap).to eq('myHandicap')
      expect(asker.v_diploma).to eq('myDiploma')
      expect(asker.v_category).to eq('myCategory')
      expect(asker.v_duree_d_inscription).to eq('myInscription')
      expect(asker.v_allocation_type).to eq('myAllocationType')
      expect(asker.v_allocation_value_min).to eq('myAllocationValue')
      expect(asker.v_age).to eq('myAge')
      expect(asker.v_location_citycode).to eq('myAllocation')
    end
  end
end
