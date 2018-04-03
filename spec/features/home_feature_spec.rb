require 'rails_helper'
require 'spec_helper'

feature 'HomeSpec' do 

  scenario 'Displays the footer through c-footer component' do
    visit root_path
    expect(page).to have_css('.c-footer')
  end

  scenario 'Display examples through c-newhomeexample component' do
    visit root_path
    expect(page).to have_css('.c-newhomeexample')
  end

  scenario 'Display recall through c-newhomerecall component' do
    visit root_path
    expect(page).to have_css('.c-newhomerecall')
  end

  scenario 'User go to first question if he/she clicks on the recall CTA' do
    visit root_path
    expect(current_path).to eq root_path
    click_on('home-recall')
    expect(current_path).to eq new_inscription_question_path
  end

end
