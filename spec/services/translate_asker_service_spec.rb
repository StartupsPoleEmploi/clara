require 'rails_helper'

describe TranslateAskerService do

  describe '.to_french' do
    it 'Resists to badly initialized service' do
      asker = TranslateAskerService.new("wrong_input").to_french
      expect(asker.attributes).to eq(Asker.new.attributes)
    end
    it 'Translates harki true to v_harki oui' do
      asker = TranslateAskerService.new({harki: true}).to_french
      expect(asker.v_harki).to eq("oui")
    end
    it 'Translates harki false to v_harki non' do
      asker = TranslateAskerService.new({harki: false}).to_french
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
    it 'Translates international_protection true to v_protection_internationale oui' do
      asker = TranslateAskerService.new({international_protection: "true"}).to_french
      expect(asker.v_protection_internationale).to eq("oui")
    end
    it 'Translates international_protection false to v_protection_internationale non' do
      asker = TranslateAskerService.new({international_protection: "false"}).to_french
      expect(asker.v_protection_internationale).to eq("non")
    end
    it 'Translates international_protection azerty to v_protection_internationale nil' do
      asker = TranslateAskerService.new({international_protection: "azerty"}).to_french
      expect(asker.v_protection_internationale).to eq(nil)
    end
    it 'Translates diploma level_1 to v_diplome niveau_1' do
      asker = TranslateAskerService.new({diploma: "level_1"}).to_french
      expect(asker.v_diplome).to eq("niveau_1")
    end
    it 'Translates diploma level_2 to v_diplome niveau_2' do
      asker = TranslateAskerService.new({diploma: "level_2"}).to_french
      expect(asker.v_diplome).to eq("niveau_2")
    end
    it 'Translates diploma level_2 to v_diplome niveau_2' do
      asker = TranslateAskerService.new({diploma: "level_2"}).to_french
      expect(asker.v_diplome).to eq("niveau_2")
    end
    it 'Translates diploma level_3 to v_diplome niveau_3' do
      asker = TranslateAskerService.new({diploma: "level_3"}).to_french
      expect(asker.v_diplome).to eq("niveau_3")
    end
    it 'Translates diploma level_4 to v_diplome niveau_4' do
      asker = TranslateAskerService.new({diploma: "level_4"}).to_french
      expect(asker.v_diplome).to eq("niveau_4")
    end
    it 'Translates diploma level_5 to v_diplome niveau_5' do
      asker = TranslateAskerService.new({diploma: "level_5"}).to_french
      expect(asker.v_diplome).to eq("niveau_5")
    end
    it 'Translates diploma level_below_5 to v_diplome niveau_infra_5' do
      asker = TranslateAskerService.new({diploma: "level_below_5"}).to_french
      expect(asker.v_diplome).to eq("niveau_infra_5")
    end
    it 'Translates diploma azerty to v_diplome nil' do
      asker = TranslateAskerService.new({diploma: "azerty"}).to_french
      expect(asker.v_diplome).to eq(nil)
    end
    it 'Translates category categories_12345 to v_category cat_12345' do
      asker = TranslateAskerService.new({category: "categories_12345"}).to_french
      expect(asker.v_category).to eq("cat_12345")
    end
    it 'Translates category other_categories to v_category autres_cat' do
      asker = TranslateAskerService.new({category: "other_categories"}).to_french
      expect(asker.v_category).to eq("autres_cat")
    end
    it 'Translates category azerty to v_category nil' do
      asker = TranslateAskerService.new({category: "azerty"}).to_french
      expect(asker.v_category).to eq(nil)
    end
    it 'Translates inscription_period more_than_a_year to v_duree_d_inscription plus_d_un_an' do
      asker = TranslateAskerService.new({inscription_period: "more_than_a_year"}).to_french
      expect(asker.v_duree_d_inscription).to eq("plus_d_un_an")
    end
    it 'Translates inscription_period less_than_a_year to v_duree_d_inscription moins_d_un_an' do
      asker = TranslateAskerService.new({inscription_period: "less_than_a_year"}).to_french
      expect(asker.v_duree_d_inscription).to eq("moins_d_un_an")
    end
    it 'Translates inscription_period not_registered to v_duree_d_inscription non_inscrit' do
      asker = TranslateAskerService.new({inscription_period: "not_registered"}).to_french
      expect(asker.v_duree_d_inscription).to eq("non_inscrit")
    end
    it 'Translates inscription_period azerty to v_duree_d_inscription nil' do
      asker = TranslateAskerService.new({inscription_period: "azerty"}).to_french
      expect(asker.v_duree_d_inscription).to eq(nil)
    end
    it 'Translates monthly_allocation_value into v_allocation_value_min' do
      asker = TranslateAskerService.new({monthly_allocation_value: 1242}).to_french
      expect(asker.v_allocation_value_min).to eq("1242")
    end
    it 'Translates age into v_age' do
      asker = TranslateAskerService.new({age: 42}).to_french
      expect(asker.v_age).to eq("42")
    end
  end

end
