class AidesController < ApplicationController

  after_action :save_asker

  def index
    if have_active_asker?
      existing = pull_existing_from_cache
      if (existing)
        hydrate_view(existing)
        instantiate_asker(existing)
      else
        pull_asker_from_query_param
        augment_asker
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
    if (params[:for_id] == 'random')
      @asker = RandomAskerService.new.go
    else
      @asker = TranslateB64AskerService.new.from_b64(params[:for_id])
    end
  end

  def pull_existing_from_cache
    Rails.cache.read(params[:for_id]) if params[:for_id] != "random"
  end

  def write_to_cache(cacheable)
    CacheService.get_instance.write(params[:for_id], cacheable)
  end

  def augment_asker
    RehydrateAddressService.new(@asker).from_citycode!
  end

  def create_cacheable_results_from_asker
    SerializeResultsService.get_instance.go(@asker)
  end

  def hashify_results(stuff)
    DisplayResultsService.new(stuff).go
  end

end
