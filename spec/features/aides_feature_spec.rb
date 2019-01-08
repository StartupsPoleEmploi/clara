require 'rails_helper'

feature 'Aides page' do 

  context 'No active user' do
    seen = nil
    before do
      if !seen
        create_2_different_aids(create(:contract_type, :contract_type_1))
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

  context 'Active user, cache empty, random user,' do
    # See https://makandracards.com/makandra/46189-how-to-rails-cache-for-individual-rspec-tests
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
    result_page = nil
    before do
      if result_page == nil
        # fill database
        asker = create(:asker, :full_user_input)
        contract_type = create(:contract_type, :contract_type_1)
        create_eligible_aid_for(asker, contract_type)
        create_ineligible_aid_for(asker, contract_type)
        disable_http_service
        allow(Rails).to receive(:cache).and_return(memory_store)
        Rails.cache.clear
        # set system under test
        visit aides_path + '?for_id=random'
        result_page = Nokogiri::HTML(page.html)
      end
    end
    after do
      enable_http_service
      Rails.cache.clear
    end
    scenario '2 aids are displayed' do
      expect(result_page.css('.c-resultaid').count).to eq 2
    end
  end

  context 'Active user, cache empty' do
    # See https://makandracards.com/makandra/46189-how-to-rails-cache-for-individual-rspec-tests
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
    before do
      # fill database
      asker = create(:asker, :full_user_input)
      contract_type = create(:contract_type, :contract_type_1)
      create_eligible_aid_for(asker, contract_type)
      create_ineligible_aid_for(asker, contract_type)
      disable_http_service
      allow(Rails).to receive(:cache).and_return(memory_store)
      Rails.cache.clear
      # set system under test
      visit aides_path + '?for_id=' + TranslateB64AskerService.new.into_b64(asker)
    end
    after do
      enable_http_service
      Rails.cache.clear
    end
    scenario 'Various checks amongst generated page passes' do
      result_page = Nokogiri::HTML(page.html)
      expect(result_page.css('.c-resultaid').count).to eq(2), 
        "2 aids should be displayed"

      expect(result_page.css('#eligibles .c-resultaid').count).to eq(1),
        "1 is eligible"

      expect(result_page.css('#ineligibles .c-resultaid').count).to eq(1),
        "1 is ineligible"
      
      expect(result_page.css('title').text.include?("Vos résultats")).to eq(true),
        "Title include \"Vos résultats\""

      expect(result_page.css('.c-breadcrumb').count).to eq(1),
        "Breadcrumb is displayed"

      expect(result_page.css('.c-detail-void').count).to eq(0),
        "No detail-void"

      expect(result_page.css('.c-result-all').count).to eq(0),
        "No result-all"

    end

  end
  
  context 'Active user, cache filled' do
    # See https://makandracards.com/makandra/46189-how-to-rails-cache-for-individual-rspec-tests
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
    result_page = nil
    before do
      if result_page == nil
        # set up data context
        main_id = "MzQsMixvLDEsMyxuLHAsOTExMTQsMTQzLG8="
        asker = TranslateB64AskerService.new.from_b64(main_id)
        contract_type = create(:contract_type, :contract_type_1)
        create_eligible_aid_for(asker, contract_type)
        create_ineligible_aid_for(asker, contract_type)
        # mock externalities
        disable_http_service
        allow(Rails).to receive(:cache).and_return(memory_store)
        Rails.cache.clear
        Rails.cache.write(main_id, SerializeResultsService.get_instance.go(asker))
        # set system under test
        visit aides_path + '?for_id=' + TranslateB64AskerService.new.into_b64(asker)
        result_page = Nokogiri::HTML(page.html)
      end
    end
    after do
      enable_http_service
      Rails.cache.clear
    end
    scenario '2 aids are displayed' do
      expect(result_page.css('.c-resultaid').count).to eq 2
    end
    scenario '1 is eligible' do
      expect(result_page.css('#eligibles .c-resultaid').count).to eq 1
    end
    scenario '1 is ineligible' do
      expect(result_page.css('#ineligibles .c-resultaid').count).to eq 1
    end
    scenario 'Title include "Vos résultats"' do
      expect(result_page.css('title').text.include?("Vos résultats")).to eq true
    end
    scenario 'Breadcrumb is displayed' do
      expect(result_page.css('.c-breadcrumb').count).to eq 1
    end
    scenario 'No detail-void' do
      expect(result_page.css('.c-detail-void').count).to eq 0
    end
    scenario 'No result-all' do
      expect(result_page.css('.c-result-all').count).to eq 0
    end
  end

  def stub_cache_with_1_eligible_2_ineligible
      cache_layer = instance_double("CacheService")
      allow(cache_layer).to receive(:read).and_return(realistic_cache_value)
      CacheService.set_instance(cache_layer)
  end

  def visit_aides_for_asker(asker)
    visit aides_path + '?for_id=' + TranslateB64AskerService.new.into_b64(asker)
  end

  def visit_aides_for_id(id)
    visit aides_path + '?for_id=' + id
  end

  def create_realistic_asker
    return create(:asker, :full_user_input)
  end

  def create_aid_spectacle(contract_type)
    create(:aid, :aid_spectacle, name: "aid_spectacle_1", contract_type: contract_type)
  end

  def create_aid_not_spectacle(contract_type)
    create(:aid, :aid_not_spectacle, name: "aid_not_spectacle_1", contract_type: contract_type)
  end

  def create_eligible_aid_for(asker, contract_type)
    asker.v_spectacle == "true" ? create_aid_spectacle(contract_type) : create_aid_not_spectacle(contract_type)
  end

  def create_ineligible_aid_for(asker, contract_type)
    asker.v_spectacle == "false" ? create_aid_spectacle(contract_type) : create_aid_not_spectacle(contract_type)
  end

  def create_2_different_aids(contract_type)
    create(:aid, :aid_spectacle, contract_type: contract_type)
    create(:aid, :aid_agepi, contract_type: contract_type)
  end

  def realistic_cache_value
    {:flat_all_eligible=>[{"id"=>4, "name"=>"Aides soit spectacle soit plus de 30", "what"=>"<p>Une description pour&nbsp;Aides soit spectacle soit plus de 30</p>", "slug"=>"aides-soit-spectacle-soit-plus-de-30", "short_description"=>"ou spectacle ou 30+", "how_much"=>"<p>un montant pour&nbsp;Aides soit spectacle soit plus de 30</p>", "additionnal_conditions"=>"<p>crit&egrave;res compl&eacute;mentaire pour&nbsp;Aides soit spectacle soit plus de 30</p>", "how_and_when"=>"<p>comment faire la demande pour&nbsp;Aides soit spectacle soit plus de 30</p>", "limitations"=>"<p>r&eacute;serves pour&nbsp;Aides soit spectacle soit plus de 30</p>", "rule_id"=>4, "ordre_affichage"=>0, "contract_type_id"=>6, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Type d'aide pour les spectacles"}], :flat_all_ineligible=>[{"id"=>1, "name"=>"aide aux plus de 30 ans", "what"=>"<p>description compl&egrave;te aides aux plus de 30 ans</p>", "slug"=>"aide-aux-plus-de-30-ans", "short_description"=>"un aide bienvenue", "how_much"=>"", "additionnal_conditions"=>"", "how_and_when"=>"", "limitations"=>"", "rule_id"=>1, "ordre_affichage"=>0, "contract_type_id"=>5, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Toutes les aides liées à l'âge du demandeur d'emploi"}, {"id"=>3, "name"=>"Aides aux spectacles de plus de 30 ans", "what"=>"<p>une description pour l'Aides aux spectacles de plus de 30 ans</p>", "slug"=>"aides-aux-spectacles-de-plus-de-30-ans", "short_description"=>"spectacle et 30+", "how_much"=>"", "additionnal_conditions"=>"", "how_and_when"=>"", "limitations"=>"", "rule_id"=>3, "ordre_affichage"=>0, "contract_type_id"=>6, "archived_at"=>nil, "contract_type_order"=>0, "contract_type_icon"=>"", "contract_type_description"=>"Type d'aide pour les spectacles"}], :asker=>{:v_handicap=>false, :v_spectacle=>true, :v_diplome=>"niveau_3", :v_category=>nil, :v_duree_d_inscription=>nil, :v_allocation_value_min=>nil, :v_allocation_type=>nil, :v_qpv=>"ne s'applique pas", :v_zrr=>"", :v_age=>28, :v_location_label=>nil, :v_location_route=>nil, :v_location_city=>nil, :v_location_country=>nil, :v_location_zipcode=>nil, :v_location_citycode=>nil, :v_location_street_number=>nil, :v_location_state=>nil}}
  end

end

