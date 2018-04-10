require "rails_helper"

describe TranslateAskerService do

  it ".to_french Resists to badly initialized service" do
     asker = TranslateAskerService.new("wrong_input").to_french
     expect(asker.attributes).to eq(Asker.new.attributes)
  end

  describe ".to_french Nominal cases" do
    
    inputs = [
      {english: {spectacle: true},             french: {v_spectacle: "oui"}},
      {english: {spectacle: "true"},           french: {v_spectacle: "oui"}},
      {english: {spectacle: false},            french: {v_spectacle: "non"}},
      {english: {spectacle: "false"},          french: {v_spectacle: "non"}},
      {english: {spectacle: "wrong_input"},    french: {v_spectacle: nil}},
      
      {english: {disabled: true},          french: {v_handicap: "oui"}},
      {english: {disabled: "true"},        french: {v_handicap: "oui"}},
      {english: {disabled: false},         french: {v_handicap: "non"}},
      {english: {disabled: "false"},       french: {v_handicap: "non"}},
      {english: {disabled: "wrong_input"}, french: {v_handicap: nil}},

      {english: {diploma: "level_1"},      french: {v_diplome: "niveau_1"}},
      {english: {diploma: "level_2"},      french: {v_diplome: "niveau_2"}},
      {english: {diploma: "level_3"},      french: {v_diplome: "niveau_3"}},
      {english: {diploma: "level_4"},      french: {v_diplome: "niveau_4"}},
      {english: {diploma: "level_5"},      french: {v_diplome: "niveau_5"}},
      {english: {diploma: "level_below_5"},french: {v_diplome: "niveau_infra_5"}},
      {english: {diploma: "wrong_input"},  french: {v_diplome: nil}},

      {english: {category: "categories_12345"},  french: {v_category: "cat_12345"}},
      {english: {category: "other_categories"},  french: {v_category: "autres_cat"}},
      {english: {category: "wrong_input"},       french: {v_category: nil}},
      
      {english: {inscription_period: "more_than_a_year"},  french: {v_duree_d_inscription: "plus_d_un_an"}},
      {english: {inscription_period: "less_than_a_year"},  french: {v_duree_d_inscription: "moins_d_un_an"}},
      {english: {inscription_period: "not_registered"},    french: {v_duree_d_inscription: "non_inscrit"}},
      {english: {inscription_period: "wrong_input"},       french: {v_duree_d_inscription: nil}},

      {english: {monthly_allocation_value: "1242"},       french: {v_allocation_value_min: "1242"}},
      {english: {monthly_allocation_value: 1242},         french: {v_allocation_value_min: "1242"}},
      {english: {monthly_allocation_value: "wrong_input"},french: {v_allocation_value_min: nil}},

      {english: {age: "42"},       french: {v_age: "42"}},
      {english: {age: 42},         french: {v_age: "42"}},
      {english: {age: "wrong_input"},french: {v_age: nil}},

      {english: {allocation_type: "ARE_ASP"},               french: {v_allocation_type: "ARE_ASP"}},
      {english: {allocation_type: "ASS_AER_ATA_APS_ASFNE"}, french: {v_allocation_type: "ASS_AER_ATA_APS_AS-FNE"}},
      {english: {allocation_type: "RPS_RFPA_RFF_PENSION"},  french: {v_allocation_type: "RPS_RFPA_RFF_pensionretraite"}},
      {english: {allocation_type: "RSA"},                    french: {v_allocation_type: "RSA"}},
      {english: {allocation_type: "AAH"},                    french: {v_allocation_type: "AAH"}},
      {english: {allocation_type: "none"},                    french: {v_allocation_type: "pas_indemnise"}},
      {english: {allocation_type: "wrong_input"},           french: {v_allocation_type: nil}},
    ]

    inputs.each do |i|
      it "Should translate #{i[:english]} to #{i[:french]}" do
        asker = TranslateAskerService.new(i[:english]).to_french
        expect(asker[i[:french].keys.first]).to eq(i[:french].values.first)        
      end
    end
    
  end

end
