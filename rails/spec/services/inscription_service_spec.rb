require 'rails_helper'

describe InscriptionService do


  describe '.download_from_asker' do
    it 'Returns a new inscription form with value filled from given v_duree_d_inscription asker' do
      # given
      asker = Asker.new
      inscription = InscriptionForm.new
      asker.v_duree_d_inscription = 'a_duree'

      # when
      result = InscriptionService.new(asker).download_from_asker
      
      # then   
      expect(result.class.to_s).to eq('InscriptionForm')
      expect(result.value).to eq('a_duree')
    end
  end

  describe '.upload' do
    it 'should inject allocation_type into asker' do
      # given
      asker = Asker.new
      inscription = InscriptionForm.new
      inscription.value = '2_years'

      # when
      InscriptionService.new(asker).upload_to_asker(inscription)

      # then
      expect(asker.v_duree_d_inscription).to eq('2_years')
    end
    it 'if value is "non_inscrit", then v_category is "not_applicable"' do
      # given
      asker = Asker.new
      asker.v_category = "foo"
      inscription = InscriptionForm.new
      inscription.value = 'non_inscrit'

      # when
      InscriptionService.new(asker).upload_to_asker(inscription)

      # then
      expect(asker.v_category).to eq('not_applicable')
    end
    it 'if value is NOT "non_inscrit", then v_category is left as-is' do
      # given
      asker = Asker.new
      asker.v_category = "foo"
      inscription = InscriptionForm.new
      inscription.value = '2_years'

      # when
      InscriptionService.new(asker).upload_to_asker(inscription)

      # then
      expect(asker.v_category).to eq('foo')
    end
  end

end
