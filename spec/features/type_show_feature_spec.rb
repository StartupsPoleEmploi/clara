require 'rails_helper'

feature 'A show type page' do
  context 'Nominal' do
    before do
      @contract_type = create(:contract_type, :contract_type_amob)
      create(:aid, :aid_spectacle, name: "aid_spectacle_1", contract_type: @contract_type, ordre_affichage: 12)
      create(:aid, :aid_not_spectacle, name: "aid_not_spectacle_1", contract_type: @contract_type, ordre_affichage: 7)
      visit type_path(@contract_type.slug)
    end
    it "Should contain all elements" do
      expect(page).to(have_css(".c-detail-title--amob-name", count:1), "Should have css of contract_type slug")
      expect(page).to(have_css(".c-detail-title-inside", count:1), "Should have title container for contract_type")
      expect(page).to(have_css(".c-detail-title-inside", text:"d3"), "Should have title of contract_type")
    end

  end
  # context 'All aids' do
  #   seen = nil
  #   before do
  #     if !seen
  #       @contract_type = create(:contract_type, :contract_type_amob)
  #       create(:aid, :aid_spectacle, name: "aid_spectacle_1", contract_type: @contract_type, ordre_affichage: 12)
  #       create(:aid, :aid_not_spectacle, name: "aid_not_spectacle_1", contract_type: @contract_type, ordre_affichage: 7)
  #       visit aides_path
  #       seen = Nokogiri::HTML(page.html)
  #     end
  #   end
  #   it "Must NOT have explanation block" do
  #     should_have seen, 0, ".c-type-explanation"
  #   end
  # end
end

