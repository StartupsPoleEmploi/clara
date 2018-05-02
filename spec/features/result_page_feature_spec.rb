require 'rails_helper'

feature 'result page' do 

  context 'Nominal' do
    before(:each) do
      disable_http_service
      v_age = create(:variable, :age)
      
      r_qpv = create(:rule, :be_in_qpv)
      r_more_than_18 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '18')
      r_more_than_19 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '19')
      r_more_than_20 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '20')
      r_more_than_21 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '21')
      r_less_than_18 = create(:rule, variable: v_age, operator_type: :less_than, value_eligible: '18')
      r_eqal_than_18 = create(:rule, variable: v_age, operator_type: :eq, value_eligible: '18')
      r_less_or_eq_18 = create(:rule, variable: v_age, operator_type: :less_or_equal_than, value_eligible: '18')

      contract_type_more   = create(:contract_type, name: 'more'  , description: 'more_description',   slug: 'more-slug',    business_id: 'more-id',   ordre_affichage: 4)
      contract_type_lessor = create(:contract_type, name: 'lessor', description: 'lessor_description', slug: 'lessor-slug',  business_id: 'lessor-id', ordre_affichage: 1)
      contract_type_less   = create(:contract_type, name: 'less'  , description: 'less_description',   slug: 'less-slug',    business_id: 'less-id',   ordre_affichage: 2)
      contract_type_eqal   = create(:contract_type, name: 'eqal'  , description: 'eqal_description',   slug: 'eqal-slug',    business_id: 'eqal-id',   ordre_affichage: 0)
      contract_type_qpv    = create(:contract_type, name: 'qpv'   , description: 'qpv_description',    slug: 'eqal-sqpvlug', business_id: 'qpv-id',    ordre_affichage: 3)

      aid_more_than_18 = create(:aid, name: 'aid_more_than_18', rule: r_more_than_18, contract_type: contract_type_more, ordre_affichage: 0)
      aid_more_than_19 = create(:aid, name: 'aid_more_than_19', rule: r_more_than_19, contract_type: contract_type_more, ordre_affichage: 2)
      aid_more_than_20 = create(:aid, name: 'aid_more_than_20', rule: r_more_than_20, contract_type: contract_type_more, ordre_affichage: 1)
      aid_more_than_21 = create(:aid, name: 'aid_more_than_21', rule: r_more_than_20, contract_type: contract_type_more, ordre_affichage: 3)
      aid_less_than_18 = create(:aid, name: 'aid_less_than_18', rule: r_less_than_18, contract_type: contract_type_less, ordre_affichage: 0)
      aid_eqal_than_18 = create(:aid, name: 'aid_eqal_than_18', rule: r_eqal_than_18, contract_type: contract_type_eqal, ordre_affichage: 0)
      aid_less_or_eq_18 = create(:aid, name: 'aid_lessor', rule: r_less_or_eq_18, contract_type: contract_type_lessor, ordre_affichage: 0)
      aid_qpv = create(:aid, name: 'aid_qpv', rule: r_qpv, contract_type: contract_type_qpv, ordre_affichage: 0)
      
      visit aides_path
    end
    after(:each) do
      enable_http_service
    end
    
    it 'Shows all actives aides' do
      expect(n('.c-result-aid')).to eq(8)

      expect(n('.c-result-line.more-id')).to eq(1)
      expect(n('.c-result-line.more-id .c-result-aid')).to eq(4)
      expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_18')).to eq(1)
      expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_19')).to eq(1)
      expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_20')).to eq(1)
      expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_21')).to eq(1)

      a = (find_all(".c-result-line.more-id .c-result-aid")).collect(&:text).map(&:strip)
      expect(a).to eq(["aid_more_than_18\nEn savoir plus", "aid_more_than_20\nEn savoir plus", "aid_more_than_19\nEn savoir plus", "aid_more_than_21\nEn savoir plus"])

      expect(n('.c-result-line__description')).to eq(0)

      expect(n('.c-result-line--green')).to eq 0
      expect(n('.c-result-line--green')).to eq 0 
      expect(n('.c-result-line--green')).to eq 0 

      expect(n('.c-result-situation')).to eq 0

      expect(n('.c-result-list--eligible')).to eq 0

      expect(n('.c-result-list--ineligible')).to eq 0

      a = page.all('a.c-result-aid').map { |e| e[:href] }
      expect(a.all? {|e| e.include?("/") && !e.include?("?for_id=")}).to eq true
    end
  end

  # context 'With normal asker' do
  #   before(:each) do
  #     disable_http_service
  #     asker = create(:asker, :fully_calculated_asker)
  #     visit aides_path + '?for_id=' + ConvertAskerInBase64Service.new.into_base64(asker)
  #   end
  #   after(:each) do
  #     enable_http_service
  #   end
  #   it 'contract_type description is displayed and contains number and pluralized description' do
  #     expect(t('.c-result-line.more-id .c-result-line__description')).to eq('4 more_descriptions')

  #     expect(n('.c-result-line.more-id')).to eq(1)
  #     expect(n('.c-result-line.more-id .c-result-aid')).to eq(4)
  #     expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_18')).to eq(1)
  #     expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_19')).to eq(1)
  #     expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_20')).to eq(1)
  #     expect(n('.c-result-line.more-id .c-result-aid.aid_more_than_21')).to eq(1)

  #     a = (find_all(".c-result-line.more-id .c-result-aid")).collect(&:text).map(&:strip)
  #     expect(a).to eq(["aid_more_than_18 En savoir plus", "aid_more_than_20 En savoir plus", "aid_more_than_19 En savoir plus", "aid_more_than_21 En savoir plus"])

  #     expect(n('.c-result-list--ineligible .c-result-line')).to eq(3)

  #     a = (find_all(".c-result-list--ineligible .c-result-line__description")).collect(&:text).map(&:strip)
  #     expect(a).to eq(["1 eqal_description", "1 lessor_description", "1 less_description"])

  #     expect(n('.c-result-aid')).to eq(8)

  #     expect(n('.c-result-situation')).to eq 1

  #     expect(n('.c-result-list--eligible')).to eq 1
  #     expect(n('.c-result-list--eligible .c-result-line')).to be >= 1

  #     expect(n('.c-result-list--uncertain')).to eq 1
  #     expect(n('.c-result-list--uncertain .c-result-line')).to be >= 1

  #     expect(n('.c-result-list--ineligible')).to eq 1
  #     expect(n('.c-result-list--ineligible .c-result-line')).to be >= 1        

  #     expect(n('.c-result-list--eligible')).to eq 1
  #     expect(n('.c-result-list--eligible .c-result-line--green')).to be >= 1 

  #     expect(n('.c-result-list--uncertain')).to eq 1
  #     expect(n('.c-result-list--uncertain .c-result-line--orange')).to be >= 1 

  #     expect(n('.c-result-list--ineligible')).to eq 1
  #     expect(n('.c-result-list--ineligible .c-result-line--red')).to be >= 1 

  #     a = page.all('a.c-result-aid').map { |e| e[:href] }
  #     expect(a.all? {|e| e.include?("/") && e.include?("?for_id=")}).to eq true
  #   end
  # end

end
