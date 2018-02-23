require 'rails_helper'
require 'support/gon_extraction_helper'

feature 'Aides page' do 

  context 'No active user' do
    before do
      create_2_different_aids
      disable_http_service
      visit aides_path
    end
    scenario 'Should display 2 aids NOT related to any eligibility' do
      display_2_aids_unrelated_to_eligibility
    end
    scenario 'Should not display breadcrumb' do
      expect(page).not_to have_css('.c-breadcrumb')
    end
    after do
      enable_http_service
    end
  end
  
  context 'An active asker DOESNT Exist already in the cache' do
    before do
      asker = create_realistic_asker
      create_eligible_aid_for(asker)
      create_ineligible_aid_for(asker)
      disable_http_service
      visit_aides_for_asker(asker)
    end
    scenario 'Should display 1 eligible and 1 ineligible aid' do
      display_1_eligible_1_ineligible
    end
    after do
      enable_http_service
    end
  end

  context 'An active asker ALREADY Exist already in the cache' do
    before do
      disable_http_service
      stub_cache_with_1_eligible_2_ineligible
      visit_aides_for_id('any')
    end
    scenario 'Should display 1 eligible and 2 ineligible aid' do
      display_1_eligible_2_ineligible
    end
    after do
      enable_http_service
      enable_cache_service
    end
  end

  def stub_cache_with_1_eligible_2_ineligible
      cache_layer = instance_double("CacheService")
      allow(cache_layer).to receive(:read).and_return(realistic_cache_value)
      CacheService.set_instance(cache_layer)
  end

  def visit_aides_for_asker(asker)
    visit aides_path + '?for_id=' + ConvertAskerInBase64Service.new.into_base64(asker)
  end

  def visit_aides_for_id(id)
    visit aides_path + '?for_id=' + id
  end

  def create_realistic_asker
    return create(:asker, :full_user_input)
  end

  def create_aid_harki
    create(:aid, :aid_harki, name: "aid_harki_1")
  end

  def create_aid_not_harki
    create(:aid, :aid_not_harki, name: "aid_not_harki_1")
  end

  def create_eligible_aid_for(asker)
    asker.v_harki == 'oui' ? create_aid_harki : create_aid_not_harki
  end

  def create_ineligible_aid_for(asker)
    asker.v_harki == 'non' ? create_aid_harki : create_aid_not_harki
  end

  def create_2_different_aids
    create(:aid, :aid_harki)
    create(:aid, :aid_agepi)
  end

  def display_2_aids_unrelated_to_eligibility
    check_count(2,0,0)
  end

  def display_1_eligible_1_ineligible
    check_count(2,1,1)
  end

  def display_1_eligible_2_ineligible
    check_count(3,1,2)
  end

  def check_count(raw_aids_number, eligible_aids_number, ineligible_aids_number)
    expect(page).to have_css('.c-result-aid', count: raw_aids_number)
    expect(page).to have_css('.c-result-list--eligible .c-result-aid', count: eligible_aids_number)
    expect(page).to have_css('.c-result-list--ineligible .c-result-aid', count: ineligible_aids_number)
  end

  def realistic_cache_value
    {:flat_all_eligible=>[{"id"=>4, "name"=>"Aides soit harki soit plus de 30", "what"=>"<p>Une description pour&nbsp;Aides soit harki soit plus de 30</p>", "slug"=>"aides-soit-harki-soit-plus-de-30", "short_description"=>"ou harki ou 30+", "how_much"=>"<p>un montant pour&nbsp;Aides soit harki soit plus de 30</p>", "additionnal_conditions"=>"<p>crit&egrave;res compl&eacute;mentaire pour&nbsp;Aides soit harki soit plus de 30</p>", "how_and_when"=>"<p>comment faire la demande pour&nbsp;Aides soit harki soit plus de 30</p>", "limitations"=>"<p>r&eacute;serves pour&nbsp;Aides soit harki soit plus de 30</p>", "rule_id"=>4, "ordre_affichage"=>0, "contract_type_id"=>6, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Type d'aide pour les harkis"}], :flat_all_ineligible=>[{"id"=>1, "name"=>"aide aux plus de 30 ans", "what"=>"<p>description compl&egrave;te aides aux plus de 30 ans</p>", "slug"=>"aide-aux-plus-de-30-ans", "short_description"=>"un aide bienvenue", "how_much"=>"", "additionnal_conditions"=>"", "how_and_when"=>"", "limitations"=>"", "rule_id"=>1, "ordre_affichage"=>0, "contract_type_id"=>5, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Toutes les aides liées à l'âge du demandeur d'emploi"}, {"id"=>3, "name"=>"Aides aux harkis de plus de 30 ans", "what"=>"<p>une description pour l'Aides aux harkis de plus de 30 ans</p>", "slug"=>"aides-aux-harkis-de-plus-de-30-ans", "short_description"=>"harki et 30+", "how_much"=>"", "additionnal_conditions"=>"", "how_and_when"=>"", "limitations"=>"", "rule_id"=>3, "ordre_affichage"=>0, "contract_type_id"=>6, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Type d'aide pour les harkis"}], :asker=>{:v_handicap=>"non", :v_harki=>"oui", :v_detenu=>"oui", :v_protection_internationale=>"oui", :v_diplome=>"niveau_3", :v_category=>nil, :v_duree_d_inscription=>nil, :v_allocation_value_min=>nil, :v_allocation_type=>nil, :v_qpv=>"ne s'applique pas", :v_zrr=>"", :v_age=>28, :v_location_label=>nil, :v_location_route=>nil, :v_location_city=>nil, :v_location_country=>nil, :v_location_zipcode=>nil, :v_location_citycode=>nil, :v_location_street_number=>nil, :v_location_state=>nil}}
  end

end

