require 'rails_helper'

feature 'Situation of asker in the result page' do 

RSpec.shared_examples "a field of the asker situation" do |details|
  before do
    qpv_and_zrr_both_ok
    disable_cache_service
  end
  after do
    enable_qpv_zrr_service
    enable_cache_service
  end
  it "#{details[:css_suffix]} must#{details[:css_text] ? '' : ' NOT'} be displayed #{details[:css_text] ? 'with text' : ''} \"#{details[:css_text]}\"" do
    asker = details[:asker] == "nominal" ? build(:asker, :full_user_input) : Asker.new
    visit_aides_for_asker(asker)

    if (details[:css_text]) 
      expect(page).to have_css(".c-situation--#{details[:css_suffix]}",  text: "#{details[:css_text]}")
    else 
      expect(page).not_to have_css(".c-situation--#{details[:css_suffix]}")
    end
  end
end

describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'inscription',            css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'category'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'allocation-type',        css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'allocation-montant'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'age',                    css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'grade',                  css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'address',                css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'zrr',                    css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'qpv',                    css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'harki',                  css_text: 'indisponible'} end
describe "Empty asker" do it_should_behave_like "a field of the asker situation", {asker: "empty", css_suffix: 'handicap',               css_text: 'indisponible'} end

describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'inscription',        css_text: 'plus d\'un an'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'category',           css_text: 'hors 12345'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'allocation-type',    css_text: 'AAH'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'allocation-montant', css_text: '0'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'age',                css_text: '35'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'grade',              css_text: 'Bac +1 à +2'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'address',            css_text: '45 Rue du Gas 79160 Villiers-en-Plaine'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'zrr',                css_text: 'oui'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'qpv',                css_text: 'oui'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'harki',              css_text: 'non'} end
describe "Nominal asker" do it_should_behave_like "a field of the asker situation", {asker: "nominal", css_suffix: 'handicap',           css_text: 'non'} end


  def visit_aides_for_asker(asker)
    visit aides_path + '?for_id=' + ConvertAskerInBase64Service.new.into_base64(asker)
  end

end
