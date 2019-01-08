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
    it '"none" props should be nil, if one of the other props is not true' do
      # given
      asker = Asker.new
      asker.v_spectacle = "true"
      asker.v_handicap  = "false"
      asker.v_cadre  = "true"

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.none).to eq(nil)
    end
    it '"none" props should be true, if all of the other props is false' do
      # given
      asker = Asker.new
      asker.v_spectacle = "false"
      asker.v_handicap  = "false"
      asker.v_cadre  = "false"

      # when
      other = OtherService.new(asker).download_from_asker

      # then
      expect(other.none).to eq("true")
    end
  end

  describe '.upload_to_asker' do
    it 'should inject params into asker' do
      # given
      asker = Asker.new
      other = OtherForm.new
      other.val_spectacle    = 'ze_val_spectacle'
      other.val_handicap = 'ze_val_handicap'
      other.val_cadre = 'ze_val_cadre'
      other.none = 'ze_none'

      # when
      OtherService.new(asker).upload_to_asker(other)

      # then
      expect(asker.v_handicap).to eq("true")
      expect(asker.v_spectacle).to eq("true")
      expect(asker.v_cadre).to eq("true")
    end
  end
end
