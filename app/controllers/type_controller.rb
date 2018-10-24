class TypeController < ApplicationController

  def show
    if have_active_asker?
      existing = pull_existing_from_cache
      if (existing)
        instantiate_asker(existing)
      else
        pull_asker_from_query_param
        augment_asker
        cacheable = create_cacheable_results_from_asker
        write_to_cache(cacheable)
      end
    else
      activated = ActivatedModelsService.instance
      contract = activated.contracts.detect{ |contract| contract["slug"] ==  params[:id] }
      aids_of_contract = activated.aids.find_all{ |aid| aid["contract_type_id"] == contract["id"] }
      hydrate_view(
        contract:  contract,
        aids: aids_of_contract
      )
    end

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
end
