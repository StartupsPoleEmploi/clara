require 'rails_helper'

describe TranslateAskerService do

  describe '.to_french' do
    it 'Resists to badly initialized service' do
      asker = TranslateAskerService.new("wrong_input").to_french
      expect(asker.attributes).to eq(Asker.new.attributes)
    end
    it 'Translates harki true to v_harki oui' do
      asker = TranslateAskerService.new({harki: "true"}).to_french
      expect(asker.v_harki).to eq("oui")
    end
    it 'Translates harki false to v_harki non' do
      asker = TranslateAskerService.new({harki: "false"}).to_french
      expect(asker.v_harki).to eq("non")
    end
    it 'Translates harki azerty to v_harki nil' do
      asker = TranslateAskerService.new({harki: "azerty"}).to_french
      expect(asker.v_harki).to eq(nil)
    end
    it 'Translates disabled true to v_handicap oui' do
      asker = TranslateAskerService.new({disabled: "true"}).to_french
      expect(asker.v_handicap).to eq("oui")
    end
  end

end
