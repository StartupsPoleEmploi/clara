require 'rails_helper'

feature 'Aides page' do 

  context 'No active user' do
    seen = nil
    before do
      if !seen
        create_2_different_aids
        disable_http_service
        visit aides_path
        seen = Nokogiri::HTML(page.html)        
      end
    end
    scenario 'Should display 2 aids NOT related to any eligibility' do
      should_have seen, 2, ".c-result-aid"
      should_have seen, 0, ".c-result-list--eligible .c-result-aid"
      should_have seen, 0, ".c-result-list--ineligible .c-result-aid"
    end
    scenario 'Should have in the title "Découvrez toutes les aides et mesures de retour à l\'emploi"' do
      should_have seen, "1st", "title", :with_text_that_include, "Découvrez toutes les aides et mesures de retour à l'emploi"
    end
    scenario 'Should have .c-result-all displayed' do
      should_have seen, 1, ".c-result-all"
    end
    scenario 'Should have a breadcrumb displayed' do
      should_have seen, 1, ".c-breadcrumb"
    end
    scenario 'Should NOT have .c-result-default displayed' do
      should_have seen, 0, ".c-result-default"
    end
    scenario 'Should have .c-detail-void' do
      should_have seen, 1, ".c-detail-void"
    end
    after do
      enable_http_service
    end
  end
  
  context 'An active asker DOESNT Exist already in the cache' do
    seen = nil
    before do
      if !seen
        asker = create_realistic_asker
        create_eligible_aid_for(asker)
        create_ineligible_aid_for(asker)
        disable_http_service
        visit_aides_for_asker(asker)
        seen = Nokogiri::HTML(page.html)
      end
    end
    scenario 'Should display 1 eligible and 1 ineligible aid' do
      should_have seen, 2, ".c-result-aid"
      should_have seen, 1, ".c-result-list--eligible .c-result-aid"
      should_have seen, 1, ".c-result-list--ineligible .c-result-aid"
    end
    scenario 'Should have in the title "Vos résultats"' do
      should_have seen, "1st", "title", :with_text_that_include, "Vos résultats"
    end
    scenario 'Should NOT have .c-result-all displayed' do
      should_have seen, 0, ".c-result-all"
    end
    scenario 'Should have a breadcrumb displayed' do
      should_have seen, 1, ".c-breadcrumb"
    end
    scenario 'Should have .c-result-default displayed' do
      should_have seen, 1, ".c-result-default"
    end
    scenario 'Should NOT have .c-detail-void' do
      should_have seen, 0, ".c-detail-void"
    end
    after do
      enable_http_service
    end
  end

  context 'An active asker ALREADY Exist already in the cache' do
    seen = nil
    before do
      if !seen
        disable_http_service
        stub_cache_with_1_eligible_2_ineligible
        visit_aides_for_id('any')
        seen = Nokogiri::HTML(page.html)
      end
    end
    scenario 'Should display 1 eligible and 2 ineligible aid' do
      should_have seen, 3, ".c-result-aid"
      should_have seen, 1, ".c-result-list--eligible .c-result-aid"
      should_have seen, 2, ".c-result-list--ineligible .c-result-aid"
    end
    scenario 'Should have in the title "Vos résultats"' do
      should_have seen, "1st", "title", :with_text_that_include, "Vos résultats"
    end
    scenario 'Should NOT have .c-result-all displayed' do
      should_have seen, 0, ".c-result-all"
    end
    scenario 'Should have a breadcrumb displayed' do
      should_have seen, 1, ".c-breadcrumb"
    end
    scenario 'Should have .c-result-default displayed' do
      should_have seen, 1, ".c-result-default"
    end
    scenario 'Should NOT have .c-detail-void' do
      should_have seen, 0, ".c-detail-void"
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

  def create_aid_spectacle
    create(:aid, :aid_spectacle, name: "aid_spectacle_1")
  end

  def create_aid_not_spectacle
    create(:aid, :aid_not_spectacle, name: "aid_not_spectacle_1")
  end

  def create_eligible_aid_for(asker)
    asker.v_spectacle == 'oui' ? create_aid_spectacle : create_aid_not_spectacle
  end

  def create_ineligible_aid_for(asker)
    asker.v_spectacle == 'non' ? create_aid_spectacle : create_aid_not_spectacle
  end

  def create_2_different_aids
    create(:aid, :aid_spectacle)
    create(:aid, :aid_agepi)
  end

  def realistic_cache_value
    {:flat_all_eligible=>[{"id"=>4, "name"=>"Aides soit spectacle soit plus de 30", "what"=>"<p>Une description pour&nbsp;Aides soit spectacle soit plus de 30</p>", "slug"=>"aides-soit-spectacle-soit-plus-de-30", "short_description"=>"ou spectacle ou 30+", "how_much"=>"<p>un montant pour&nbsp;Aides soit spectacle soit plus de 30</p>", "additionnal_conditions"=>"<p>crit&egrave;res compl&eacute;mentaire pour&nbsp;Aides soit spectacle soit plus de 30</p>", "how_and_when"=>"<p>comment faire la demande pour&nbsp;Aides soit spectacle soit plus de 30</p>", "limitations"=>"<p>r&eacute;serves pour&nbsp;Aides soit spectacle soit plus de 30</p>", "rule_id"=>4, "ordre_affichage"=>0, "contract_type_id"=>6, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Type d'aide pour les spectacles"}], :flat_all_ineligible=>[{"id"=>1, "name"=>"aide aux plus de 30 ans", "what"=>"<p>description compl&egrave;te aides aux plus de 30 ans</p>", "slug"=>"aide-aux-plus-de-30-ans", "short_description"=>"un aide bienvenue", "how_much"=>"", "additionnal_conditions"=>"", "how_and_when"=>"", "limitations"=>"", "rule_id"=>1, "ordre_affichage"=>0, "contract_type_id"=>5, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Toutes les aides liées à l'âge du demandeur d'emploi"}, {"id"=>3, "name"=>"Aides aux spectacles de plus de 30 ans", "what"=>"<p>une description pour l'Aides aux spectacles de plus de 30 ans</p>", "slug"=>"aides-aux-spectacles-de-plus-de-30-ans", "short_description"=>"spectacle et 30+", "how_much"=>"", "additionnal_conditions"=>"", "how_and_when"=>"", "limitations"=>"", "rule_id"=>3, "ordre_affichage"=>0, "contract_type_id"=>6, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Type d'aide pour les spectacles"}], :asker=>{:v_handicap=>"non", :v_spectacle=>"oui", :v_diplome=>"niveau_3", :v_category=>nil, :v_duree_d_inscription=>nil, :v_allocation_value_min=>nil, :v_allocation_type=>nil, :v_qpv=>"ne s'applique pas", :v_zrr=>"", :v_age=>28, :v_location_label=>nil, :v_location_route=>nil, :v_location_city=>nil, :v_location_country=>nil, :v_location_zipcode=>nil, :v_location_citycode=>nil, :v_location_street_number=>nil, :v_location_state=>nil}}
  end

end

