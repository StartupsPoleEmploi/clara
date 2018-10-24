class EligibilityController < ApplicationController

  def eligible
    cached_results = pull_existing_from_cache
    if (cached_results)
      instantiate_asker(cached_results)
    else
      pull_asker_from_query_param
      augment_asker
      cached_results = create_cacheable_results_from_asker
      write_to_cache(cached_results)
    end
    hydrate_view(
      eligibilities:  cached_results["flat_all_eligible"],
    )
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
