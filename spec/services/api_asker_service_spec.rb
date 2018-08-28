require 'rails_helper'

describe ApiAskerService do
  describe '.to_asker' do
    it 'Should transform to asker' do
      #given
      asker = ApiAsker.new
      asker.v_spectacle = 'mySpectacle'
      asker.v_disabled = 'myHandicap'
      asker.v_diploma = 'myDiploma'
      asker.v_category = 'myCategory' 
      asker.v_inscription_period = 'myInscription'
      asker.v_allocation_type = 'myAllocationType'
      asker.v_monthly_allocation_value = 'myAllocationValue'
      asker.v_age = 'myAge'
      asker.v_location_citycode = 'myCitycode'
      #when
      ApiAskerService.new(asker).to_asker
      #then 
      expect(asker.v_ec).to eq('ttttttt')
      expect(asker.v_spectacle).to eq('mySpectacle')
      expect(asker.v_handicap).to eq('myHandicap')
      expect(asker.v_diplome).to eq('myDiploma')
      expect(asker.v_category).to eq('myCategory')
      expect(asker.v_duree_d_inscription).to eq('myInscription')
      expect(asker.v_allocation_type).to eq('myAllocationType')
      expect(asker.v_allocation_value_min).to eq('myAllocationValue')
      expect(asker.v_age).to eq('myAge')
      expect(asker.v_location_citycode).to eq('myCitycode')
    end
  end
end
