require 'securerandom'

FactoryBot.define do

  factory :filter do
  end

  factory :need_filter do
  end

  factory :custom_filter do
  end

  factory :custom_parent_filter do
  end

  factory :stat do
  end

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

    trait :spectacle do 
      name 'v_spectacle'
      elements 'oui,non'
      variable_type :selectionnable
    end

    trait :duree_d_inscription do 
      name "v_duree_d_inscription"
      elements "plus_d_un_an,moins_d_un_an,non_inscrit"
      elements_translation "plus d'un an,moins d'un an,non inscrit"
      variable_type :selectionnable
    end

    trait :handicap do 
      name 'v_handicap'
      variable_type :selectionnable
    end

    trait :qpv do 
      name 'v_qpv'
      description 'oui,non'
      variable_type :selectionnable
    end

    trait :location_state do 
      name 'v_location_state'
      variable_type :string
    end

    trait :zrr do 
      name 'v_zrr'
      description 'oui,non'
      variable_type :selectionnable
    end

    trait :categorie do 
      name 'v_category'
      variable_type :selectionnable
    end

    trait :allocation_type do 
      name 'v_allocation_type'
      variable_type :selectionnable
    end

    trait :allocation_value_min do 
      name 'v_allocation_value_min'
      variable_type :integer
    end

    trait :location_citycode do 
      name 'v_location_citycode'
      variable_type :string
    end

  end

  factory :rule do 
    sequence(:name) { |n| "rule_#{n}" }
  
    trait :old_inscription do
      name 'old_inscription' 
      kind 'simple' 
      association :variable, :duree_d_inscription
      operator_kind :equal
      value_eligible 'plus_d_un_an'
    end

    trait :be_paris do
      name 'be_paris' 
      kind 'simple' 
      association :variable, :location_citycode
      operator_kind :equal
      value_eligible '75056'
    end

    trait :be_an_adult do
      name 'be_an_adult' 
      kind 'simple' 
      association :variable, :age
      operator_kind :more_than
      value_eligible '18'
    end

    trait :be_a_child do
      name 'be_a_child' 
      kind 'simple' 
      association :variable, :age
      operator_kind :less_than
      value_eligible '18'
    end

    trait :be_in_qpv do
      name 'be_in_qpv' 
      kind 'simple' 
      association :variable, :qpv
      operator_kind :equal
      value_eligible 'oui'
    end

    trait :be_in_guyane do
      name 'be_in_guyane' 
      kind 'simple' 
      association :variable, :location_state
      operator_kind :starts_with
      value_eligible 'guyane'
    end

    trait :be_in_zrr do
      name 'be_in_zrr' 
      kind 'simple' 
      association :variable, :zrr
      operator_kind :equal
      value_eligible 'oui'
    end

    trait :not_be_an_adult do
      name 'not_be_an_adult' 
      kind 'simple' 
      association :variable, :age
      operator_kind :less_than
      value_eligible '18'
    end

    trait :have_allocation_below_min do 
      name 'have_allocation_below_min' 
      kind 'simple' 
      association :variable, :allocation_value_min
      operator_kind :less_than
      value_eligible '149'
    end

    trait :be_a_spectacle do 
      name 'be_a_spectacle' 
      kind 'simple' 
      association :variable, :spectacle
      operator_kind :equal
      value_eligible "oui"
    end

    trait :not_be_a_spectacle do 
      name 'not_be_a_spectacle' 
      kind 'simple' 
      association :variable, :spectacle
      operator_kind :equal
      value_eligible "non"
    end

    trait :be_handicaped do 
      name 'be_a_handicaped' 
      kind 'simple' 
      association :variable, :handicap
      operator_kind :equal
      value_eligible "oui"
    end

    trait :be_an_adult_and_a_spectacles do 
      kind 'composite' 
      composition_type :and_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_a_spectacle, name: 'composed_be_a_spectacle0'), FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult0')]
      end
    end


    trait :be_an_adult_or_a_spectacles do 
      kind 'composite' 
      composition_type :or_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_a_spectacle, name: 'composed_be_a_spectacle1', description: 'spectacle description'), FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult1', description: 'adult description')]
      end
    end

    trait :be_an_adult_and_in_qpv do 
      kind 'composite' 
      composition_type :and_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult2'), FactoryBot.create(:rule, :be_in_qpv, name: 'composed_be_qpv1')]
      end
    end

    trait :be_in_qpv_and_in_zrr do 
      kind 'composite' 
      composition_type :and_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_in_qpv, name: 'composed_be_qpvgeo'), FactoryBot.create(:rule, :be_in_zrr, name: 'composed_be_in_zrrgeo')]
      end
    end

    trait :be_an_adult_or_in_qpv do 
      kind 'composite' 
      composition_type :or_rule
      before :create do |rule|
        rule.slave_rules << [FactoryBot.create(:rule, :be_an_adult, name: 'composed_be_an_adult3'), FactoryBot.create(:rule, :be_in_qpv, name: 'composed_be_qpv2')]
      end
    end

  end

  factory :aid do 
    sequence(:name) { |n| "Aide #{n}" }
    before :create do |aid|
      aid.ordre_affichage = 42
      aid.contract_type = create(:contract_type, name: "ct_#{aid.name}", description: "d_#{aid.name}", category: "c_#{aid.name}")
    end
    trait :aid_spectacle do
      before :create do |aid|
        aid.rule = create(:rule, :be_a_spectacle)
      end
    end
    trait :aid_adult do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult)
      end
    end
    trait :aid_not_spectacle do
      before :create do |aid|
        aid.rule = create(:rule, :not_be_a_spectacle)
        aid.what = "&lt;p&gt;Cette aide vise &amp;agrave; faciliter les d&amp;eacute;placements des personnes handicap&amp;eacute;es salari&amp;eacute;es, travailleurs ind&amp;eacute;pendants, demandeurs d&amp;#39;emploi, &amp;eacute;tudiants de l&amp;#39;enseignement sup&amp;eacute;rieur en stage obligatoire, stagiaires de la formation professionnelle"
      end
    end
    trait :aid_adult_or_spectacle do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_or_a_spectacles)
        aid.how_much = 'how much value'
        aid.how_and_when = 'how and when value'
        aid.limitations = 'limitations value'
        aid.what = 'what value'
        aid.additionnal_conditions = 'additionnal conditions value'
        aid.short_description = 'a short description'
      end
    end
    trait :aid_adult_and_spectacle do
      before :create do |aid|
        aid.rule = create(:rule, :be_an_adult_and_a_spectacles)
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
      category 'aide'
    end
    trait :contract_type_2 do 
      name 'n2'
      description 'd2'
      category 'dispositif'
    end
    trait :contract_type_amob do 
      name "aide-a-la-mobilite"
      description 'd3'
    end
  end

  factory :zrr_url do
  end

  factory :asker do 
    skip_create
    v_age '25'
    v_spectacle "non"

    trait :ado do 
      v_age '16'
    end

    trait :adult do 
      v_age '33'
    end

    trait :spectacle do 
      v_spectacle "oui"
    end

    trait :handicaped do 
      v_handicap "oui"
    end

    trait :full_user_input do 
      v_handicap "oui"
      v_spectacle "non"
      v_cadre "oui"
      v_diplome 'niveau_3'
      v_category 'autres_cat'
      v_duree_d_inscription 'plus_d_un_an'
      v_allocation_value_min 340
      v_allocation_type 'ARE_ASP'
      v_age 35
      v_location_citycode '79351'
    end
    
  end
end
