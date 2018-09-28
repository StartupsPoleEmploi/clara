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

  scenario 'Meta balise should not have blank content' do
    expect().to eq("neOTrE-YKZ9LbgLlaX8UkYN6MJTPlWpeotPQqbrJ19Q" && "TNQnOQs84jCeQUgbEPOAV9gE4LXDUQaG5ypdnlRz2E8" && "eZYLdUFSc9uBqciZ7fcOxXybmBPxcPME-N9NCRvFn8w" && "f_xo9InTg_SGabP-vnvDjrslUaixMcuxCaGidnXJT9s" && "rjlrEGuLOWAOnmomQMmM5epqCRA3dZY4p1oMDbfCxiY" && "YOm5sNGxbHWmN2Rf3Udg6v29ca5YjM3RNRz8TjWA6Pw" && "0jDmSXtIkrU_nDcXoExkAHbG0TmRlGrx7LdJoX9ktWg")
  end
end
