require 'rails_helper'
require 'spec_helper'

feature 'CookieSpec' do 

  scenario 'When visiting the home page, hotjar script is included by default' do
    visit root_path
    expect(page).to have_selector("#hj-script", visible: false)
  end

  scenario 'When visiting the home page, 2 analytics scripts are included by default' do
    visit root_path
    expect(page).to have_selector("#ga-script", visible: false)
    expect(page).to have_selector("#ga-create-script", visible: false)
  end
  
  scenario 'When visiting the home page, dimension1 (fromPE) is set to true or false' do
    visit root_path
    expect(page).to have_selector("#ga-frompe", visible: false)
  end
  
  scenario 'When visiting any page, dimension1 (fromPE) is set to true or false' do
    visit new_other_question_path
    expect(page).to have_selector("#ga-frompe", visible: false)
    visit new_grade_question_path
    expect(page).to have_selector("#ga-frompe", visible: false)
  end
  
  context 'User is from PE' do
    scenario 'There is a script that points the fromPE analytics var to true' do
      allow_any_instance_of( ApplicationHelper ).to receive(:from_pe?).and_return(true) 
      visit root_path
      expect(page).to have_selector("#ga-frompe", visible: false)
      expect(page).to have_selector("#ga-frompe.ga-frompe-true", visible: false)
      expect(page).not_to have_selector("#ga-frompe.ga-frompe-false", visible: false)
    end
  end
  context 'User is NOT from PE' do
    scenario 'There is a script that points the fromPE analytics var to false' do
      allow_any_instance_of( ApplicationHelper ).to receive(:from_pe?).and_return(false) 
      visit root_path
      expect(page).to have_selector("#ga-frompe", visible: false)
      expect(page).not_to have_selector("#ga-frompe.ga-frompe-true", visible: false)
      expect(page).to have_selector("#ga-frompe.ga-frompe-false", visible: false)
    end
  end

  
  scenario 'When visiting RGPD page, statistics are enabled by default' do
    visit edit_cooky_path("preference")
    disable_statistics_checkbox = "input#input_stat"
    expect(page.find(disable_statistics_checkbox)).not_to be_checked
  end

  scenario 'When visiting RGPD page, navigation is enabled by default' do
    visit edit_cooky_path("preference")
    disable_navigation_checkbox = "input#input_nav"
    expect(page.find(disable_navigation_checkbox)).not_to be_checked
  end

  scenario 'User can refuse analytics' do

    # Given
    visit root_path
    expect(page).to have_selector("#ga-script", visible: false)
    expect(page).to have_selector("#ga-create-script", visible: false)

    #When
    visit edit_cooky_path("preference")
    find("#input_stat").set(true)
    find("#submit-cookie-preference").click

    #Then
    visit root_path
    expect(page).not_to have_selector("#ga-script", visible: false)
    expect(page).not_to have_selector("#ga-create-script", visible: false)

  end

  scenario 'User can refuse hotjar' do
    # Given
    visit root_path
    expect(page).to have_selector("#hj-script", visible: false)

    #When
    visit edit_cooky_path("preference")
    find("#input_nav").set(true)
    find("#submit-cookie-preference").click

    #Then
    visit root_path
    expect(page).not_to have_selector("#hj-script", visible: false)
  end


end
