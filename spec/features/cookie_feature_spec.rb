require 'rails_helper'
require 'spec_helper'

feature 'CookieSpec' do 

  scenario 'When visiting the home page, hotjar script is included by default' do
    visit root_path
    expect(page).to have_selector("#hj-script", visible: false)
  end

  scenario 'When visiting the home page, 3 analytics scripts are included by default' do
    visit root_path
    expect(page).to have_selector("#ga-script", visible: false)
    expect(page).to have_selector("#ga-create-script", visible: false)
    expect(page).to have_selector("#ga-frompe", visible: false)
  end
  
  scenario 'User can refuse analytics' do

    # Given
    visit root_path
    expect(page).to have_selector("#ga-script", visible: false)
    expect(page).to have_selector("#ga-create-script", visible: false)
    expect(page).to have_selector("#ga-frompe", visible: false)

    #When
    visit edit_cooky_path("preference")
    find("#forbid_statistic").set(true)
    find("#submit-cookie-preference").click

    #Then
    visit root_path
    expect(page).not_to have_selector("#ga-script", visible: false)
    expect(page).not_to have_selector("#ga-create-script", visible: false)
    expect(page).not_to have_selector("#ga-frompe", visible: false)

  end

  scenario 'User can refuse hotjar' do
    # Given
    visit root_path
    expect(page).to have_selector("#hj-script", visible: false)

    #When
    visit edit_cooky_path("preference")
    find("#forbid_navigation").set(true)
    find("#submit-cookie-preference").click

    #Then
    visit root_path
    expect(page).not_to have_selector("#hj-script", visible: false)
  end


end
