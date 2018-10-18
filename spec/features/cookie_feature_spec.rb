require 'rails_helper'
require 'spec_helper'

feature 'CookieSpec' do 

  scenario 'When visiting the home page, hotjar script is included by default' do
    visit root_path
    #
  end
  scenario 'When visiting the home page, analytics script is included by default' do
    visit root_path
    #
  end
  scenario 'When visiting RGPD page, all cookies are accepted by user' do
    visit edit_cooky_path("preference")
    #
  end

  scenario 'When visiting RGPD page, the form points to a page request, in order to force head reevaluation, thus removing hotjar and analytics from head if use do not want them' do
    visit edit_cooky_path("preference")
    expect(page).not_to have_css('form[data-remote="true"]')
    visit root_path
    expect(page).to have_css('form[data-remote="true"]')
  end

  scenario 'User can refuse hotjar' do
    visit edit_cooky_path("preference")
    #
  end

  scenario 'User can refuse analytics' do
    visit edit_cooky_path("preference")
    #
  end


end
