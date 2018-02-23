require 'rails_helper'

feature 'Admin simulation' do 

  def expect_registration_zone_to_be_visible
    expect(find_all(".simulation-save").count).to be 1
    expect(find_all(".eligibility-sth").count).to be 1
  end

  def expect_registration_zone_to_be_hidden
    expect(find_all(".simulation-save").count).to be 0
    expect(find_all(".eligibility-sth").count).to be 0
  end

  before { sign_in } 

  context 'No simulation previously registered' do

    $btn_simulate = '#btn_simulate'
    $input_simulation_name = 'input.simulation-save__name'
    $button_save_simulation = 'button.simulation-save__action'
    $registered_simulation_name = 'td.simulation-table-name'
    $registered_simulation_result = 'td.simulation-table-result'
    $button_replay = 'button.simulation-table-replay'
    $button_delete = 'button.simulation-table-delete'

    before(:each) do
      create(:rule, :be_an_adult)
      visit admin_rule_path(Rule.last.id)
    end


    scenario 'By default, simulator is displayed on detail of rule page' do 
      expect(page).to have_css('.simulator')
    end
      
  end

  context 'Many simulation previously registered' do

    before(:each) do
      create(:rule, :be_an_adult)
      create(:custom_rule_check, name: 'Age as adult', hsh: {:v_age => 26}, result: 'true', rule: Rule.last)
      create(:custom_rule_check, name: 'Age : limit case', hsh: {:v_age => 18}, result: 'true', rule: Rule.last)
      create(:custom_rule_check, name: 'Age as teenager', hsh: {:v_age => 16}, result: 'false', rule: Rule.last)
      create(:custom_rule_check, name: 'Age ok but bad others fields', hsh: {:v_age => 20, :v_category => 'cat', :v_diplome => 'dip'}, result: 'true', rule: Rule.last)

      visit admin_rule_path(Rule.last.id)

    end

  end
end
