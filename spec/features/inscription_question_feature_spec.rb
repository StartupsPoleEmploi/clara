require 'rails_helper'
require 'support/gon_extraction_helper'

feature 'inscription question' do 

  scenario 'By default there is no error label' do 
    visit new_inscription_question_path
    expect(page).not_to have_css('label.is-error')
  end

  scenario 'If user validates without any checked checkboxes, user stay on page with an error message' do 
    # given
    visit new_inscription_question_path
    expect_all_unchecked([find('#non_inscrit'), find('#moins_d_un_an'), find('#plus_d_un_an')])
    # when
    find('.js-next').click
    # then
    expect(current_path).to eq new_inscription_question_path
    expect(page).to have_css('label.is-error')
  end

    
  RSpec.shared_examples "a simple inscription page scenario" do |details|
    before do
      # given
      visit new_inscription_question_path
      page.choose(details[:choose])
      # when
      find('.js-next').click
    end
    scenario "goes to #{details[:target_path]}" do
      expect(current_path).to eq path_of(details[:target_path])
    end
    scenario "fulfill current form with #{details[:choose]}" do
      gon = extract_gon(first('head script', visible: false).native.inner_text)
      expect(gon["asker"]["v_duree_d_inscription"]).to eq(details[:choose])
    end
  end

  RSpec.shared_examples "an inscription page scenario where category exists" do |details|
    before do
      visit new_category_question_path
      page.choose('autres_cat')
      find('.js-next').click

      visit new_inscription_question_path
      page.choose(details[:choose])
      find('.js-next').click
    end
    scenario "asker loaded with v_duree_d_inscription:#{details[:choose]} v_category:#{details[:exp_category] == nil ? 'null' : details[:exp_category]}" do
      gon = extract_gon(first('head script', visible: false).native.inner_text)
      expect(gon["asker"]["v_duree_d_inscription"]).to eq(details[:choose])
      expect(gon["asker"]["v_category"]).to eq(details[:exp_category])
    end
  end

  describe "If user validates plus_d_un_an"  do it_should_behave_like "a simple inscription page scenario", {choose: 'plus_d_un_an', target_path: 'new_category_question_path'} end
  describe "If user validates moins_d_un_an" do it_should_behave_like "a simple inscription page scenario", {choose: 'moins_d_un_an', target_path: 'new_category_question_path'} end
  describe "If user validates non_inscrit"   do it_should_behave_like "a simple inscription page scenario", {choose: 'non_inscrit', target_path: 'new_allocation_question_path'} end
  describe "If user validates plus_d_un_an with category"  do it_should_behave_like "an inscription page scenario where category exists", {choose: 'plus_d_un_an', exp_category: 'autres_cat'} end
  describe "If user validates moins_d_un_an with category" do it_should_behave_like "an inscription page scenario where category exists", {choose: 'moins_d_un_an', exp_category: 'autres_cat'} end
  describe "If user validates non_inscrit with category"   do it_should_behave_like "an inscription page scenario where category exists", {choose: 'non_inscrit', exp_category: 'not_applicable'} end


  def path_of(stuff)
    RoutesList.all_simplified_pathes[stuff]
  end  

end
