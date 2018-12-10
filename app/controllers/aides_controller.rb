class AidesController < ApplicationController

  after_action :save_asker

  def index
    if have_active_asker?
      existing = pull_existing_from_cache
      if (existing)
        instantiate_asker(existing)
        hydrate_view(existing)
      else
        pull_asker_from_query_param
        augment_asker
        cacheable = create_cacheable_results_from_asker
        write_to_cache(cacheable)
        hydrate_view(cacheable)
      end
    else
      # hydrate_view(hash_of_all_active_aids)
      aaa = _searchable_aids
      @stuff = aaa.map { |e| e.id  }
      p '- - - - - - - - - - - - - - @stuff- - - - - - - - - - - - - - - -' 
      pp @stuff
      p ''
    end
  end

  def _searchable_aids
    Aid.all.activated.page(2).per(5)
  end

  def search_for_aids
  end

  def hash_of_all_active_aids
    activated = ActivatedModelsService.instance
    aids = activated.aids
    contracts = activated.contracts
    contract_type_ids = aids.map{|e| e["contract_type_id"]}
    res = {
      "aids" => aids,
      "contracts" => contracts.select { |contract| contract_type_ids.include?(contract["id"]) } 
    }
    res
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
    Rails.cache.write(params[:for_id], cacheable, {expires_in: 10.minutes})
  end

  def augment_asker
    RehydrateAddressService.new.from_citycode!(@asker)
  end

  def create_cacheable_results_from_asker
    SerializeResultsService.get_instance.go(@asker)
  end

end
