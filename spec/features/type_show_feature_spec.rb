require 'rails_helper'
require 'support/gon_extraction_helper'


RSpec.shared_examples "a show type page in real conditions" do |details|

  context "Nominal" do
    before(:each) do
      # Given
      @contract_type = details[:type] == 'classic' ? create_classic_contract_type : create_special_contract_type
      create_aid_harki(@contract_type)
      create_aid_not_harki(@contract_type)
      # When
      visit type_path(@contract_type.slug)
    end
    it "Should have css of contract_type business id" do
      expect(page).to have_css(".c-detail-title--#{@contract_type.business_id}", count: 1) 
    end
    it "Should have title \"#{details[:title]}\"" do
      expect(page).to have_css('.c-detail-title-inside', text: "#{details[:title]}") 
    end
    it "Should have #{details[:lines_nb]} active line(s)" do
      expect(page).to have_css('.c-result-aid', count: "#{details[:lines_nb]}")
    end
    it "Title of first active aid must be \"#{details[:first_aid_title]}\"" do
      expect(page).to have_css('.c-result-aid__title', text: "#{details[:first_aid_title]}")
    end
    it "Title of second active aid must be \"#{details[:second_aid_title]}\"" do
      expect(page).to have_css('.c-result-aid__title', text: "#{details[:second_aid_title]}")
    end
    it "Call to action with text \"Je commence\" must be present" do
      expect(page).to have_css('.c-detail-cta', text: 'Je commence')
    end
    it "Must have #{details[:explanation_nb]} explanation block" do
      expect(page).to have_css('.c-type-explanation', count: "#{details[:explanation_nb]}")
    end
  end
  def create_aid_harki(contract_type)
    create(:aid, :aid_harki, name: "aid_harki_1", contract_type: contract_type)
  end

  def create_aid_not_harki(contract_type)
    create(:aid, :aid_not_harki, name: "aid_not_harki_1", contract_type: contract_type)
  end

  def create_classic_contract_type
    create(:contract_type, :contract_type_1)
  end

  def create_special_contract_type
    create(:contract_type, :contract_type_amob)
  end
end

RSpec.describe "a classic show type page"  do it_should_behave_like "a show type page in real conditions", {type: 'classic', title: 'd1', lines_nb: 2, first_aid_title: 'aid_not_harki', second_aid_title: 'aid_harki', explanation_nb: 0} end
RSpec.describe "a special show type page"  do it_should_behave_like "a show type page in real conditions", {type: 'special', title: 'd3', lines_nb: 2, first_aid_title: 'aid_not_harki', second_aid_title: 'aid_harki', explanation_nb: 1} end

