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
    click_on('home-recall')
    expect(current_path).to eq new_inscription_question_path
  end

  scenario 'User go to first question if he/she clicks on the main CTA' do
    visit root_path
    find('.c-main-cta').click
    expect(current_path).to eq new_inscription_question_path
  end

  scenario 'Home should a meta google search controler for SebastienSEO' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="neOTrE-YKZ9LbgLlaX8UkYN6MJTPlWpeotPQqbrJ19Q"]', :visible => false
  end

  scenario 'Home should a meta google search controler for Mat' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="TNQnOQs84jCeQUgbEPOAV9gE4LXDUQaG5ypdnlRz2E8"]', :visible => false
  end

  scenario 'Home should a meta google search controler for Beg' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="eZYLdUFSc9uBqciZ7fcOxXybmBPxcPME-N9NCRvFn8w"]', :visible => false
  end

  scenario 'Home should a meta google search controler for Maxd' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="f_xo9InTg_SGabP-vnvDjrslUaixMcuxCaGidnXJT9s"]', :visible => false
  end

  scenario 'Home should a meta google search controler for Davb' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="rjlrEGuLOWAOnmomQMmM5epqCRA3dZY4p1oMDbfCxiY"]', :visible => false
  end

  scenario 'Home should a meta google search controler for Acm' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="YOm5sNGxbHWmN2Rf3Udg6v29ca5YjM3RNRz8TjWA6Pw"]', :visible => false
  end

  scenario 'Home should a meta google search controler for Mar' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"][content="0jDmSXtIkrU_nDcXoExkAHbG0TmRlGrx7LdJoX9ktWg"]', :visible => false
  end

  scenario 'Home should have 7 meta Google search controler' do
    visit root_path 
    expect(page).to have_css 'meta[name="google-site-verification"]', count:7, :visible => false
  end

end
