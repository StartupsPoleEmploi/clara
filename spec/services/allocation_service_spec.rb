require 'rails_helper'

describe AllocationService do

  describe '.new_and_download' do
    it 'Returns a new allocation form with allocation_type filled from given asker' do
      # given
      asker = Asker.new
      asker.v_allocation_type = "the allocation type"

      # when
      result = AllocationService.new.new_and_download(asker)
      
      # then   
      expect(result.class.to_s).to eq('AllocationForm')
      expect(result.type).to eq('the allocation type')
    end
  end

  describe '.upload' do
    it 'should inject allocation_type into asker' do
      # given
      asker = Asker.new
      allocation = AllocationForm.new
      allocation.type = 'allocation type value'

      # when
      AllocationService.new.upload(allocation, asker)

      # then
      expect(asker.v_allocation_type).to eq('allocation type value')
    end
    
    it 'if allocation_type is "ASS_AER_ATA_APS_AS-FNE" and v_allocation_value_min exists, v_allocation_value_min is untouched' do

      # given
      asker = Asker.new
      allocation = AllocationForm.new
      allocation.type = 'ASS_AER_ATA_APS_AS-FNE'
      asker.v_allocation_value_min = "42"

      # when
      AllocationService.new.upload(allocation, asker)

      # then
      expect(asker.v_allocation_value_min).to eq("42")
    end

    it 'if allocation_type is "ARE_ASP" and v_allocation_value_min exists, v_allocation_value_min is untouched' do

      # given
      asker = Asker.new
      allocation = AllocationForm.new
      allocation.type = 'ARE_ASP'
      asker.v_allocation_value_min = "42"

      # when
      AllocationService.new.upload(allocation, asker)

      # then
      expect(asker.v_allocation_value_min).to eq("42")
    end

    it 'if allocation_type is **anything else than ARE or ASS** and v_allocation_value_min exists, v_allocation_value_min is set to "not_applicable"' do

      # given
      asker = Asker.new
      allocation = AllocationForm.new
      allocation.type = 'azerty'
      asker.v_allocation_value_min = "42"

      # when
      AllocationService.new.upload(allocation, asker)

      # then
      expect(asker.v_allocation_value_min).to eq("not_applicable")
    end

  end
end
