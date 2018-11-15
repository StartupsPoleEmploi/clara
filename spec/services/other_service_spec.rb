require 'rails_helper'

describe OtherService do

  describe '.download_from_asker' do
    it 'should inject params into otherForm' do
      # given
      asker = Asker.new
      asker.v_spectacle  = 'ze_val_spectacle'
      asker.v_handicap   = 'ze_val_handicap'
      asker.v_cadre   = 'ze_val_cadre'

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.val_spectacle).to eq('ze_val_spectacle')
      expect(other.val_handicap).to eq('ze_val_handicap')
      expect(other.val_cadre).to eq('ze_val_cadre')
    end
    it '"none" props should be nil, if one of the other props is not "oui"' do
      # given
      asker = Asker.new
      asker.v_spectacle = 'oui'
      asker.v_handicap  = 'non'
      asker.v_cadre  = 'oui'

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.none).to eq(nil)
    end
    it '"none" props should be "oui", if all of the other props is "non"' do
      # given
      asker = Asker.new
      asker.v_spectacle = 'non'
      asker.v_handicap  = 'non'
      asker.v_cadre  = 'non'

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
      other.val_spectacle    = 'ze_val_spectacle'
      other.val_handicap = 'ze_val_handicap'
      other.none = 'ze_none'

      # when
      OtherService.new(asker).upload_to_asker(other)

      # then
      expect(asker.v_handicap).to eq('oui')
      expect(asker.v_spectacle).to eq('oui')
    end
  end
end
