require 'rails_helper'

feature 'result page' do 

  
  context 'Nominal' do

    result_page = nil

    before(:each) do
      if result_page == nil
        p "result_page is nil"
        create_nominal_schema
        visit aides_path
        result_page = Nokogiri::HTML(page.html)
      end
    end
    
    it 'Shows only actives aides' do
      number_of_aids_displayed = page.all('.c-result-aid', :visible => true).count
      expect(Aid.all.size).not_to eq(8)
      expect(Aid.activated.size).to eq(8)
      expect(number_of_aids_displayed).to eq(8)
    end

    it 'Group aid by contract type' do
      # save_and_open_page
      # p result_page
      p result_page.css('.c-result-line.more-id')[0].to_s
      # number_of_moreid_contract_type = page.all('.c-result-line.more-id', :visible => true).count
      # expect(number_of_moreid_contract_type).to eq(1)
    end

  end


  def create_nominal_schema
    v_age = create(:variable, :age)
    
    r_zrr = create(:rule, :be_in_zrr)
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
    contract_type_zrr    = create(:contract_type, name: 'zrr'   , description: 'zrr_description',    slug: 'eqal-szrrlug', business_id: 'zrr-id',    ordre_affichage: 3)

    aid_more_than_18 = create(:aid, name: 'aid_more_than_18', rule: r_more_than_18, contract_type: contract_type_more, ordre_affichage: 0)
    aid_more_than_19 = create(:aid, name: 'aid_more_than_19', rule: r_more_than_19, contract_type: contract_type_more, ordre_affichage: 2)
    aid_more_than_20 = create(:aid, name: 'aid_more_than_20', rule: r_more_than_20, contract_type: contract_type_more, ordre_affichage: 1)
    aid_more_than_21 = create(:aid, name: 'aid_more_than_21', rule: r_more_than_20, contract_type: contract_type_more, ordre_affichage: 3)
    aid_less_than_18 = create(:aid, name: 'aid_less_than_18', rule: r_less_than_18, contract_type: contract_type_less, ordre_affichage: 0)
    aid_eqal_than_18 = create(:aid, name: 'aid_eqal_than_18', rule: r_eqal_than_18, contract_type: contract_type_eqal, ordre_affichage: 0)
    aid_less_or_eq_18 = create(:aid, name: 'aid_lessor', rule: r_less_or_eq_18, contract_type: contract_type_lessor, ordre_affichage: 0)
    aid_zrr = create(:aid, name: 'aid_zrr', rule: r_zrr, contract_type: contract_type_zrr, ordre_affichage: 0)
    aid_unused = create(:aid, name: 'aid_usused', rule: r_less_than_18, contract_type: contract_type_less, ordre_affichage: 0, archived_at: Date.new)
  end

end
