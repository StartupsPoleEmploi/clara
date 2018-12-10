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
      aids_h, total_nb = _aides_index_search
      hydrate_view({
        "aids" => aids_h,
        "total_nb" => total_nb,
      })
    end
  end

  def _aides_index_search
    usearch = params.extract!(:usearch).permit(:usearch).to_h[:usearch]
    page_nb_str = params.extract!(:page).permit(:page).to_h[:page]
    page_nb = page_nb_str.blank? ? 1 : page_nb_str.to_i

    aids = nil
    if usearch
      aids = Aid.roughly_spelled_like(usearch).activated
    else
      aids = Aid.all.activated
    end
    
    @aids = aids.page(page_nb).per(5)
    @h_aids = JSON.parse(@aids.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id, :ordre_affichage ], :include => {filters: {only:[:id, :slug]}, custom_filters: {only:[:id, :slug, :custom_parent_filter_id]}, need_filters: {only:[:id, :slug]}}))
    return @h_aids, aids.size
  end

  def search_for_aids
    plain_text_search = params.extract!(:plain_text_search).permit(:plain_text_search).to_h[:plain_text_search]
    page_nb = params.extract!(:page_nb).permit(:page_nb).to_h[:page_nb]
    redirect_h = {action: "index"}
    redirect_h[:usearch] = plain_text_search unless plain_text_search.blank?
    redirect_h[:page] = page_nb unless page_nb.blank?
    redirect_to redirect_h
    # if (!page_nb.blank?)
    #   redirect_to action: "index", usearch: plain_text_search, page: page_nb
    # else
    #   redirect_to action: "index", usearch: plain_text_search
    # end
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
