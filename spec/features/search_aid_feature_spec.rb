require 'rails_helper'

feature 'Search for aids' do 

  context 'Nominal' do
    before do
      disable_http_service
      create_nominal_schema
      visit aides_path      
    end
    after do
      enable_http_service
    end
    it 'Has a search input' do
      expect(page).to have_css('input#usearch_input')
    end
    it 'Displays total number of aids' do
      expect(page).to have_css(".c-result-all-subtitle",  text: "8 aides et mesures sont disponibles sur Clara")
    end
    it 'Displays 5 aids per page' do
      expect(page).to have_css(".c-result-aid",  count: 5)
    end
    it 'Displays a normal title' do
      expect(page).to have_title "Découvrez toutes les aides et mesures de retour à l'emploi | Clara – un service Pôle emploi"
    end
    it 'Displays a pagination' do
      expect(page).to have_css("nav.pagination")
    end
    it 'User can click to next page, it updates aids, but title stay the same' do
      #given
      first_aid_before_pagination = first_displayed_aid
      #when
      find('nav.pagination .next a[rel="next"]').click
      #then
      expect(first_aid_before_pagination).not_to eq first_displayed_aid
      expect(page).to have_title "Découvrez toutes les aides et mesures de retour à l'emploi | Clara – un service Pôle emploi"
    end
    it 'User can search for something, it updates aids, URL, and title accordingly' do
      #given
      first_aid_before = first_displayed_aid
      _stub_sql_search
      #when
      search_for_something_great
      #then
      expect(first_aid_before).not_to eq first_displayed_aid
      expect(current_fullpath).to eq "/aides?usearch=more"      
      expect(page).to have_title "Résultat de recherche – 2 aides et mesures sont disponibles - page 1 sur 1 | Clara – un service Pôle emploi"
    end
    it 'User can search for something, the call is tracked if the user accepts' do
      #given
      _stub_sql_search
      search_layer = _fake_track_search
      allow_any_instance_of(CookiePreference).to receive(:ga_disabled?).and_return(false)
      #when
      search_for_something_great
      #then
      expect(current_fullpath).to eq "/aides?usearch=more"      
      expect(search_layer).to have_received(:call).with({user_search: "more"})
    end
    it 'User can search for something, the call is NOT tracked if the user does not accept' do
      #given
      _stub_sql_search
      search_layer = _fake_track_search
      allow_any_instance_of(CookiePreference).to receive(:ga_disabled?).and_return(true)
      #when
      search_for_something_great
      #then
      expect(current_fullpath).to eq "/aides?usearch=more"      
      expect(search_layer).not_to have_received(:call)
    end
    it 'Search can be accessed through URL' do
      #given
      expect(find("#usearch_input").value).to eq nil 
      first_aid_before = first_displayed_aid
      _stub_sql_search      
      #when
      visit aides_path + "?usearch=mobilite"
      #then
      expect(find("#usearch_input").value).to eq "mobilite" 
      expect(first_aid_before).not_to eq first_displayed_aid
    end
    it 'Pagination can be accessed through URL' do
      #given
      expect(find(".page.current").text).to eq "1" 
      #when
      visit aides_path + "?page=2"
      #then
      expect(find(".page.current").text).to eq "2" 
    end
    it 'Page number is resetted / disappear from URL / if user make a new search' do
      #given
      _stub_sql_search
      visit aides_path + "?page=2&usearch=mobilite"
      #when
      search_for_something_great
      #then
      expect(find(".page.current").text).to eq "1"       
      expect(current_fullpath).to eq "/aides?usearch=more"      
    end
  end

  def current_fullpath
    URI.parse(current_url).request_uri
  end

  def _stub_sql_search
    fake_search_result = two_last_aids
    allow(stub_aid_model).to receive(:roughly_spelled_like).and_return(fake_search_result)
  end

  def _fake_track_search
    track_search = class_double("TrackSearch").as_stubbed_const
    allow(track_search).to receive(:call)
    track_search
  end

  def search_for_something_great
    first('input#usearch_input').set("more")
    find(".c-search-form-submit").click
  end

  def stub_aid_model
    class_double("Aid").as_stubbed_const
  end

  def two_last_aids
     Aid.limit(2).order('id desc')
  end

  def first_displayed_aid
    find_all(".c-result-aid__title")[0].text
  end

  def create_nominal_schema
    v_age = create(:variable, :age)
    
    r_zrr = create(:rule, :be_in_zrr)
    r_more_than_18 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '18')
    r_more_than_19 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '19')
    r_more_than_20 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '20')
    r_more_than_21 = create(:rule, variable: v_age, operator_type: :more_than, value_eligible: '21')
    r_less_than_18 = create(:rule, variable: v_age, operator_type: :less_than, value_eligible: '18')
    r_eqal_than_18 = create(:rule, variable: v_age, operator_type: :eq, value_eligible: '18')
    r_less_or_eq_18 = create(:rule, variable: v_age, operator_type: :less_or_equal_than, value_eligible: '18')

    contract_type_more   = create(:contract_type, name: 'more'  , description: 'more_description',   slug: 'more-slug',    business_id: 'more-id',   ordre_affichage: 4)
    contract_type_lessor = create(:contract_type, name: 'lessor', description: 'lessor_description', slug: 'lessor-slug',  business_id: 'lessor-id', ordre_affichage: 1)
    contract_type_less   = create(:contract_type, name: 'less'  , description: 'less_description',   slug: 'less-slug',    business_id: 'less-id',   ordre_affichage: 2)
    contract_type_eqal   = create(:contract_type, name: 'eqal'  , description: 'eqal_description',   slug: 'eqal-slug',    business_id: 'eqal-id',   ordre_affichage: 0)
    contract_type_zrr    = create(:contract_type, name: 'zrr'   , description: 'zrr_description',    slug: 'eqal-szrrlug', business_id: 'zrr-id',    ordre_affichage: 3)

    aid_more_than_18 = create(:aid, name: 'aid_more_than_18', rule: r_more_than_18, contract_type: contract_type_more, ordre_affichage: 0)
    aid_more_than_19 = create(:aid, name: 'aid_more_than_19', rule: r_more_than_19, contract_type: contract_type_more, ordre_affichage: 2)
    aid_more_than_20 = create(:aid, name: 'aid_more_than_20', rule: r_more_than_20, contract_type: contract_type_more, ordre_affichage: 1)
    aid_more_than_21 = create(:aid, name: 'aid_more_than_21', rule: r_more_than_20, contract_type: contract_type_more, ordre_affichage: 3)
    aid_less_than_18 = create(:aid, name: 'aid_less_than_18', rule: r_less_than_18, contract_type: contract_type_less, ordre_affichage: 0)
    aid_eqal_than_18 = create(:aid, name: 'aid_eqal_than_18', rule: r_eqal_than_18, contract_type: contract_type_eqal, ordre_affichage: 0)
    aid_less_or_eq_18 = create(:aid, name: 'aid_lessor', rule: r_less_or_eq_18, contract_type: contract_type_lessor, ordre_affichage: 0)
    aid_zrr = create(:aid, name: 'aid_zrr', rule: r_zrr, contract_type: contract_type_zrr, ordre_affichage: 0)
    aid_unused = create(:aid, name: 'aid_usused', rule: r_less_than_18, contract_type: contract_type_less, ordre_affichage: 0, archived_at: Date.new)
  end

end
