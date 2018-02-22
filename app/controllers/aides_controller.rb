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
        create_cacheable_version_of_asker
        write_to_cache
        hashified = hashify_results(@cacheable)
        hydrate_view(hashified)
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
    @asker = ConvertAskerInBase64Service.new.from_base64(params[:for_id])
  end

  def pull_existing_from_cache
    @existing = CacheService.get_instance.read(params[:for_id])
  end

  def write_to_cache
    CacheService.get_instance.write(params[:for_id], @cacheable)
  end

  def augment_asker_with_qpv_zrr
    CalculateAskerService.new(@asker).calculate_zrr_qpv
  end

  def create_cacheable_version_of_asker
    @cacheable = SerializeResultsService.new(@asker).go
  end

  def hashify_results(stuff)
    DisplayResultsService.new(stuff).go
  end

end
