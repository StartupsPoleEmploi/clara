require 'rails_helper'

feature 'result page' do 

  context 'No User' do
    before do
      create_nominal_schema
      visit aides_path      
    end
    it 'Has a search input' do
      expect(page).to have_css('input#usearch_input')
    end
    it 'Displays total number of aids' do
      expect(page).to have_css(".c-result-all-subtitle",  text: "8 aides et mesures sont disponibles sur Clara")

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
