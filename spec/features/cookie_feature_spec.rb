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
    visit other_questions_path
    expect(page).to have_selector("#ga-frompe", visible: false)
    visit grade_questions_path
    expect(page).to have_selector("#ga-frompe", visible: false)
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
