require 'rails_helper'

feature 'A show type page' do
  context 'Nominal' do
    seen = nil
    before do
      if !seen
        @contract_type = create(:contract_type, :contract_type_amob)
        create(:aid, :aid_spectacle, name: "aid_spectacle_1", contract_type: @contract_type, ordre_affichage: 12)
        create(:aid, :aid_not_spectacle, name: "aid_not_spectacle_1", contract_type: @contract_type, ordre_affichage: 7)
        visit type_path(@contract_type.slug)
        seen = Nokogiri::HTML(page.html)
      end
    end
    it 'Should have css of contract_type business id' do
      should_have seen, 1, ".c-detail-title--amob"
    end
    it 'Should have title of contract_type' do
      should_have seen, 1, ".c-detail-title-inside", :with_text, "d3"
    end
    it 'Should have 2 aids' do
      should_have seen, 2, ".c-result-aid"
    end
    it "Title of first active aid must be aid_not_spectacle_1" do
      should_have seen, "1st", ".c-result-aid__title", :with_text, "aid_not_spectacle_1"
    end
    it "Title of second active aid must be aid_spectacle_1" do
      should_have seen, "2nd", ".c-result-aid__title", :with_text, "aid_spectacle_1"
    end
    it "Call to action with text \"Je commence\" must be present" do
      should_have seen, 1, ".c-detail-cta", :with_text, "Je commence"
    end
    it "Must have explanation block with correct number of aids" do
      should_have seen, 1, ".c-type-explanation .aid-nb-txt", :with_text, "2 aides"
    end
  end

end

