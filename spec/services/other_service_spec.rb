require 'rails_helper'

describe OtherService do

  describe '.download_from_asker' do
    it 'should inject params into otherForm' do
      # given
      asker = Asker.new
      asker.v_harki                     = 'ze_val_harki'
      asker.v_detenu                    = 'ze_val_detenu'
      asker.v_protection_internationale  = 'ze_val_pi'
      asker.v_handicap                   = 'ze_val_handicap'

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.val_harki).to eq('ze_val_harki')
      expect(other.val_detenu).to eq('ze_val_detenu')
      expect(other.val_pi).to eq('ze_val_pi')
      expect(other.val_handicap).to eq('ze_val_handicap')
    end
    it '"none" props should be nil, if one of the other props is not "oui"' do
      # given
      asker = Asker.new
      asker.v_harki                     = 'non'
      asker.v_detenu                    = 'oui'
      asker.v_protection_internationale  = 'non'
      asker.v_handicap                   = 'non'

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.none).to eq(nil)
    end
    it '"none" props should be "oui", if all of the other props is "non"' do
      # given
      asker = Asker.new
      asker.v_harki                     = 'non'
      asker.v_detenu                    = 'non'
      asker.v_protection_internationale  = 'non'
      asker.v_handicap                   = 'non'

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.none).to eq('oui')
    end
  end

  describe '.upload_to_asker' do
    it 'should inject params into asker' do
      # given
      asker = Asker.new
      other = OtherForm.new
      other.val_harki    = 'ze_val_harki'
      other.val_detenu   = 'ze_val_detenu'
      other.val_pi       = 'ze_val_pi'
      other.val_handicap = 'ze_val_handicap'
      other.none = 'ze_none'

      # when
      OtherService.new(asker).upload_to_asker(other)

      # then
      expect(asker.v_handicap).to eq('oui')
      expect(asker.v_harki).to eq('oui')
      expect(asker.v_protection_internationale).to eq('oui')
      expect(asker.v_handicap).to eq('oui')
    end
  end
end
