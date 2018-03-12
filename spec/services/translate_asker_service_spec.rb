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
    it 'Translates disabled false to v_handicap non' do
      asker = TranslateAskerService.new({disabled: "false"}).to_french
      expect(asker.v_handicap).to eq("non")
    end
    it 'Translates disabled azerty to v_handicap nil' do
      asker = TranslateAskerService.new({disabled: "azerty"}).to_french
      expect(asker.v_handicap).to eq(nil)
    end
    it 'Translates ex_invict true to v_detenu oui' do
      asker = TranslateAskerService.new({ex_invict: "true"}).to_french
      expect(asker.v_detenu).to eq("oui")
    end
    it 'Translates ex_invict false to v_detenu non' do
      asker = TranslateAskerService.new({ex_invict: "false"}).to_french
      expect(asker.v_detenu).to eq("non")
    end
    it 'Translates ex_invict azerty to v_detenu nil' do
      asker = TranslateAskerService.new({ex_invict: "azerty"}).to_french
      expect(asker.v_detenu).to eq(nil)
    end
  end

end
