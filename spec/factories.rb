FactoryBot.define do

  factory :user do
    trait :fake do
      email "foo@bar.com"
      password "secret"
      password_confirmation "secret"
    end
  end

  factory :variable do 
    trait :age  do 
      name 'v_age'
      variable_type :integer
    end

    trait :harki do 
      name 'v_harki'
      variable_type :string
    end

    trait :handicap do 
      name 'v_handicap'
      description 'oui,non'
      variable_type :string
    end

    trait :qpv do 
      name 'v_qpv'
      variable_type :string
    end

    trait :categorie do 
      name 'v_category'
      variable_type :string
    end

    trait :allocation_type do 
      name 'v_allocation_type'
      variable_type :string
    end

    trait :allocation_value_min do 
      name 'v_allocation_value_min'
      variable_type :integer
    end

  end

  factory :rule do 
    sequence(:name) { |n| "rule_#{n}" }
  
    trait :be_an_adult do
      name 'be_an_adult' 
      association :variable, :age
      operator_type :more_than
      value_eligible '18'
    end

    trait :be_a_child do
      name 'be_a_child' 
      association :variable, :age
      operator_type :less_than
      value_eligible '18'
    end

    trait :be_in_qpv do
      name 'be_in_qpv' 
      association :variable, :qpv
      operator_type :eq
      value_eligible 'en_qpv'
      value_ineligible 'hors_qpv'
    end

    trait :not_be_an_adult do
      name 'not_be_an_adult' 
      association :variable, :age
      operator_type :less_than
      value_eligible '18'
    end

    trait :have_allocation_below_min do 
      name 'have_allocation_below_min' 
      association :variable, :allocation_value_min
      operator_type :less_than
      value_eligible '149'
    end

    trait :be_a_harki do 
      name 'be_a_harki' 
      association :variable, :harki
      operator_type :eq
      value_eligible 'oui'
    end

    trait :not_be_a_harki do 
      name 'not_be_a_harki' 
      association :variable, :harki
      operator_type :eq
      value_eligible 'non'
    end

    trait :be_handicaped do 
      name 'be_a_handicaped' 
      association :variable, :handicap
      operator_type :eq
      value_eligible 'oui'
    end

    trait :be_an_adult_and_a_harkis do 
      composition_type :and_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_a_harki, name: 'composed_be_a_harki0'), FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult0')]
      end
    end


    trait :be_an_adult_or_a_harkis do 
      composition_type :or_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_a_harki, name: 'composed_be_a_harki1', description: 'harki description'), FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult1', description: 'adult description')]
      end
    end

    trait :be_an_adult_and_in_qpv do 
      composition_type :and_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult2'), FactoryBot.create(:rule, :be_in_qpv, name: 'composed_be_qpv1')]
      end
    end

    trait :be_an_adult_or_in_qpv do 
      composition_type :or_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult3'), FactoryBot.create(:rule, :be_in_qpv, name: 'composed_be_qpv2')]
      end
    end

    trait :be_an_adult_or_harkis_or_in_qpv do 
      composition_type :or_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_a_harki, name: 'composed_be_a_harki1', description: 'harki description'), FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult4', description: 'adult description'), FactoryBot.create(:rule, :be_in_qpv, name: 'composed_be_qpv3', description: 'qpv description')]
      end
    end
  end

  factory :aid do 
    sequence(:name) { |n| "Aide #{n}" }
    trait :aid_qpv do
      before :create do |aid|
        aid.rule = create(:rule, :be_in_qpv)
      end
    end
    trait :aid_harki do
      before :create do |aid|
        aid.rule = create(:rule, :be_a_harki)
      end
    end
    trait :aid_not_harki do
      before :create do |aid|
        aid.rule = create(:rule, :not_be_a_harki)
      end
    end
    trait :aid_adult_or_harki do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_or_a_harkis)
        aid.how_much = 'how much value'
        aid.how_and_when = 'how and when value'
        aid.limitations = 'limitations value'
        aid.what = 'what value'
        aid.additionnal_conditions = 'additionnal conditions value'
        aid.short_description = 'a short description'
      end
    end
    trait :aid_adult_and_harki do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_and_a_harkis)
      end
    end
    trait :aid_adult_and_qpv do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_and_in_qpv)
      end
    end
    trait :aid_adult_or_qpv do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_or_in_qpv)
      end
    end
    trait :aid_adult_or_harkis_or_qpv do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_or_harkis_or_in_qpv)
      end
    end
    trait :aid_agepi do 
      before :create do |aid|
        aid.rule = create(:rule, :have_allocation_below_min)
      end
    end
    trait :aid_disabled do 
      before :create do |aid|
        aid.rule = create(:rule, :be_handicaped)
      end
    end
  end
  
  factory :custom_rule_check do
  end

  factory :contract_type do
    trait :contract_type_1 do 
      name 'n1'
      description 'd1'
      business_id 'b1'
      category 'aide'
    end
    trait :contract_type_2 do 
      name 'n2'
      description 'd2'
      business_id 'b2'
      category 'dispositif'
    end
    trait :contract_type_amob do 
      name 'amob-name'
      description 'd3'
      slug 'amob-slug'
      business_id 'amob'
    end
  end

  factory :zrr_url do
  end

  factory :asker do 
    skip_create
    v_age '25'
    v_harki 'non'

    trait :ado do 
      v_age '16'
    end

    trait :adult do 
      v_age '33'
    end

    trait :harki do 
      v_harki 'oui'
    end

    trait :handicaped do 
      v_handicap 'oui'
    end

    trait :full_user_input do 
      v_handicap 'non'
      v_harki 'non'
      v_detenu 'non'
      v_protection_internationale 'oui'
      v_diplome 'niveau_3'
      v_category 'autres_cat'
      v_duree_d_inscription 'plus_d_un_an'
      v_allocation_value_min 0
      v_allocation_type 'AAH'
      v_qpv nil
      v_zrr nil
      v_age 35
      v_location_label '45 Rue du Gas 79160 Villiers-en-Plaine'
      v_location_route 'Rue du Gas'
      v_location_city 'Villiers-en-Plaine'
      v_location_country 'France'
      v_location_zipcode '79160'
      v_location_citycode '79351'
      v_location_street_number '45'
      v_location_state 'Nouvelle-Aquitaine (Poitou-Charentes)'
    end

    trait :fully_calculated_asker do 
      v_handicap 'non'
      v_harki 'non'
      v_detenu 'non'
      v_protection_internationale 'oui'
      v_diplome 'niveau_3'
      v_category 'autres_cat'
      v_duree_d_inscription 'plus_d_un_an'
      v_allocation_value_min 0
      v_allocation_type 'AAH'
      v_qpv 'non'
      v_zrr 'oui'
      v_age 35
      v_location_label '45 Rue du Gas 79160 Villiers-en-Plaine'
      v_location_route 'Rue du Gas'
      v_location_city 'Villiers-en-Plaine'
      v_location_country 'France'
      v_location_zipcode '79160'
      v_location_citycode '79351'
      v_location_street_number '45'
      v_location_state 'Nouvelle-Aquitaine (Poitou-Charentes)'
    end
    
  end
end
