require 'rails_helper'
require 'spec_helper'

feature 'CookieSpec' do 

  scenario 'When visiting the home page, hotjar script is included by default' do
    visit root_path
    expect(page).to have_selector("#hj-script", visible: false)
  end

  scenario 'When visiting the home page, 5 analytics scripts are included by default' do
    visit root_path
    expect(page).to have_selector("#ga-gtag-src", visible: false)
    expect(page).to have_selector("#ga-gtag-exec", visible: false)
    expect(page).to have_selector("#ga-script", visible: false)
    expect(page).to have_selector("#ga-create-script", visible: false)
    expect(page).to have_selector("#ga-frompe", visible: false)
  end
  
  scenario 'By default everything is authorized' do
    #given
    #when
    visit edit_cooky_path("preference")
    #then
    expect(find("#forbid_statistic")).not_to be_checked
    expect(find("#forbid_navigation")).not_to be_checked
    expect(find("#authorize_statistic")).to be_checked
    expect(find("#authorize_navigation")).to be_checked
  end

  scenario "The application can remember user\'s choices" do
    #given
    visit edit_cooky_path("preference")
    expect(find("#forbid_statistic")).not_to be_checked
    expect(find("#forbid_navigation")).not_to be_checked
    expect(find("#authorize_statistic")).to be_checked
    expect(find("#authorize_navigation")).to be_checked
    #when
    find("#forbid_statistic").click
    find("#forbid_navigation").click
    find("#submit-cookie-preference").click
    visit root_path
    visit edit_cooky_path("preference")
    #then
    expect(find("#forbid_statistic")).to be_checked
    expect(find("#forbid_navigation")).to be_checked
    expect(find("#authorize_statistic")).not_to be_checked
    expect(find("#authorize_navigation")).not_to be_checked
  end


  scenario 'User can refuse analytics' do

    # Given
    visit root_path
    expect(page).to have_selector("#ga-gtag-src", visible: false)
    expect(page).to have_selector("#ga-gtag-exec", visible: false)
    expect(page).to have_selector("#ga-script", visible: false)
    expect(page).to have_selector("#ga-create-script", visible: false)
    expect(page).to have_selector("#ga-frompe", visible: false)

    #When
    visit edit_cooky_path("preference")
    find("#forbid_statistic").set(true)
    find("#submit-cookie-preference").click

    #Then
    visit root_path
    expect(page).not_to have_selector("#ga-gtag-src", visible: false)
    expect(page).not_to have_selector("#ga-gtag-exec", visible: false)
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
