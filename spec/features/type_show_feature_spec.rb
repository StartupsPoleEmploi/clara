require 'rails_helper'

feature 'A show type page' do
  context 'Nominal' do
    before do
      url = _fill_db
      visit type_path(url)
    end
    it "Should contain all elements" do
      expect(page).to(have_css(".c-detail-title--aide-a-la-mobilite", count:1), "Should have css of contract_type slug")
      expect(page).to(have_css(".c-detail-title-inside", count:1), "Should have title container for contract_type")
      expect(page).to(have_css(".c-detail-title-inside", text:"d3"), "Should have title of contract_type")
      expect(page).to(have_css(".c-result-aid", count: 2), "Should have 2 aids")
      expect(page.find_all(".c-result-aid")[0]).to(have_css(".c-result-aid__title", text:"aid_not_spectacle_1"), "Should display not_spectacle_1 first")
      expect(page.find_all(".c-result-aid")[1]).to(have_css(".c-result-aid__title", text:"aid_spectacle_1"), "Should display spectacle_1 first")
      expect(page).to(have_css(".c-detail-cta", count: 1), "Should have CTA displayed")
      expect(page).to(have_css(".c-type-explanation", count: 1), "Must have explanation block")
      expect(page).to(have_css(".c-type-explanation .aid-nb-txt", count: 1, text: "2 aides"), "Must have explanation block with correct number of aids")
    end

  end
  context 'All aids' do
    before do
      _fill_db
      visit aides_path
    end
    it "Must NOT have explanation block" do
      save_and_open_page
      expect(page).to(have_css(".c-type-explanation", count: 0), "Must NOT have explanation block")
    end
  end
  def _fill_db
      contract_type = create(:contract_type, :contract_type_amob)
      aid1 = create(:aid, :aid_spectacle, name: "aid_spectacle_1")
      aid2 = create(:aid, :aid_not_spectacle, name: "aid_not_spectacle_1")
      aid1.contract_type = contract_type
      aid1.ordre_affichage = 22
      aid2.contract_type = contract_type
      aid2.ordre_affichage = 11
      aid1.save
      aid2.save
      contract_type.slug
  end
end

