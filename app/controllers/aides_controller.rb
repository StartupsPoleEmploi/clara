class AidesController < ApplicationController

  after_action :save_asker

  def index
    if have_active_asker?
      pull_existing_from_cache
      if (@existing)
        hydrate_view(hashify_results(@existing))
        instantiate_asker(@existing)
      else
        pull_asker_from_query_param
        augment_asker_with_qpv_zrr
        cacheable = create_cacheable_results_from_asker
        write_to_cache(cacheable)
        hydrate_view(cacheable)
      end
    else
      hydrate_view(hash_of_all_active_aids)
    end
  end

  def hash_of_all_active_aids
    {
      "aids" => ResultService.new.convert_to_displayable_hash(Aid.activated)
    }
  end

  def have_active_asker?
    !!params[:for_id]
  end

  def instantiate_asker(existing)
    @asker = Asker.new(existing[:asker])
  end

  def pull_asker_from_query_param

    # @asker = ConvertAskerInBase64Service.new.from_base64(params[:for_id])

    #{}"#<Asker v_age: \"32\", v_allocation_type: \"RPS_RFPA_RFF_pensionretraite\", v_allocation_value_min: \"not_applicable\", v_category: \"autres_cat\", v_diplome: \"niveau_3\", v_duree_d_inscription: \"plus_d_un_an\", v_handicap: \"oui\", v_location_city: \"Berriac\", v_location_citycode: \"11037\", v_location_country: \"France\", v_location_label: \"11000 Berriac\", v_location_route: \"\", v_location_state: \"Occitanie (Languedoc-Roussillon)\", v_location_street_number: \"\", v_location_zipcode: \"11000\", v_qpv: nil, v_spectacle: \"non\", v_zrr: nil>"

    if (params[:for_id] == 'random')
      @asker = Asker.new
      @asker.v_handicap = ["oui", "non"].sample
      @asker.v_spectacle = ["oui", "non"].sample
      @asker.v_age = Array(17..69).map(&:to_s).sample
      @asker.v_allocation_type = ["ARE_ASP", "ASS_AER_ATA_APS_AS-FNE", "RSA", "RPS_RFPA_RFF_pensionretraite", "AAH", "pas_indemnise"].sample
      @asker.v_allocation_value_min = Array(1..3000).map(&:to_s).sample
      @asker.v_diplome = ["niveau_1","niveau_2","niveau_3","niveau_4","niveau_5","niveau_infra_5"].sample
      @asker.v_category = ["cat_12345","autres_cat"].sample
      @asker.v_duree_d_inscription = ["plus_d_un_an","moins_d_un_an","non_inscrit"].sample
    else
      @asker = ConvertAskerInBase64Service.new.from_base64(params[:for_id])
    end
  end

  def pull_existing_from_cache
    @existing = CacheService.get_instance.read(params[:for_id]) if params[:for_id] != "random"
  end

  def write_to_cache(cacheable)
    CacheService.get_instance.write(params[:for_id], cacheable)
  end

  def augment_asker_with_qpv_zrr
    CalculateAskerService.new(@asker).calculate_zrr_qpv
  end

  def create_cacheable_results_from_asker
    SerializeResultsService.get_instance.go(@asker)
  end

  def hashify_results(stuff)
    DisplayResultsService.new(stuff).go
  end

end
