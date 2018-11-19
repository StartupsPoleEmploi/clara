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
  scenario 'When visiting RGPD page, all cookies are accepted by user' do
    visit edit_cooky_path("preference")
    #
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
