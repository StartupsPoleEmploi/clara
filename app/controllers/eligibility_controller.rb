class EligibilityController < ApplicationController

  def eligible
    existing = pull_existing_from_cache
    if (existing)
      instantiate_asker(existing)
    else
      pull_asker_from_query_param
      augment_asker
      cacheable = create_cacheable_results_from_asker
      write_to_cache(cacheable)
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
