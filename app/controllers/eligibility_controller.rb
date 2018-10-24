class EligibilityController < ApplicationController

  def eligible
    cached_results = extract_cached_results
    contract = ActivatedModelsService.instance.contracts.detect{ |contract| contract["slug"] ==  params[:id] }
    eligibles = cached_results[:flat_all_eligible]
    eligibles_of_contract = eligibles.find_all{ |eligible| eligible["contract_type_id"] == contract["id"] }
    view_data = {
      contract:  contract,
      aids: eligibles_of_contract
    }
    p view_data
    hydrate_view(view_data)
  end

  def extract_cached_results
    cached_results = pull_existing_from_cache
    if (cached_results)
      instantiate_asker(cached_results)
    else
      pull_asker_from_query_param
      augment_asker
      cached_results = create_cacheable_results_from_asker
      write_to_cache(cached_results)
    end
    cached_results
  end

  def pull_asker_from_query_param
    if (params[:for_id] == 'random')
      @asker = RandomAskerService.new.go
    else
      @asker = TranslateB64AskerService.new.from_b64(params[:for_id])
    end
  end

  def augment_asker
    RehydrateAddressService.new.from_citycode!(@asker)
  end

  def have_active_asker?
    !!params[:for_id]
  end

  def instantiate_asker(existing)
    @asker = Asker.new(existing[:asker])
  end

  def pull_existing_from_cache
    Rails.cache.read(params[:for_id]) if params[:for_id] != "random"
  end

  def write_to_cache(cacheable)
    Rails.cache.write(params[:for_id], cacheable, {expires_in: 10.minutes})
  end

  def create_cacheable_results_from_asker
    SerializeResultsService.get_instance.go(@asker)
  end

end
