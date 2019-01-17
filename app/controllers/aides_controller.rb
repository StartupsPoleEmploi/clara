class AidesController < ApplicationController

  after_action :save_asker

  def index
    if have_active_asker?
      pull_asker
      augment_asker_if_necessary
      results = create_results_from_asker
      hydrate_view(results)
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
      unless CookiePreference.new(current_session: session).ga_disabled?
        TrackSearch.call(user_search: usearch)
      end
    else
      aids = Aid.all.activated
    end
    
    @aids = aids.page(page_nb).per(GetPaginationSearchNumberService.call)
    @h_aids = JSON.parse(@aids.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id, :ordre_affichage ], :include => {filters: {only:[:id, :slug]}, custom_filters: {only:[:id, :slug, :custom_parent_filter_id]}, need_filters: {only:[:id, :slug]}}))
    return @h_aids, aids.size
  end

  def search_for_aids
    previous_search = params.extract!(:previous_search).permit(:previous_search).to_h[:previous_search]
    current_search = params.extract!(:plain_text_search).permit(:plain_text_search).to_h[:plain_text_search]
    page_nb = params.extract!(:page_nb).permit(:page_nb).to_h[:page_nb]
    redirect_h = {action: "index"}
    redirect_h[:usearch] = current_search unless current_search.blank?
    if previous_search != current_search
      page_nb = nil
    end
    redirect_h[:page] = page_nb unless page_nb.blank?
    redirect_to redirect_h
  end

  def have_active_asker?
    !!params[:for_id]
  end

  def instantiate_asker_from_existing_results(existing_results)
    @asker = Asker.new(existing_results[:asker])
  end

  def pull_asker
    if (params[:for_id] == 'random')
      @asker = RandomAskerService.new.go
    elsif asker_exists?
      p '- - - - - - - - - - - - - - asker_exists, yes- - - - - - - - - - - - - - - -' 
      @asker = require_asker
    else
      p '- - - - - - - - - - - - - - no asker, translate- - - - - - - - - - - - - - - -' 
      @asker = TranslateB64AskerService.new.from_b64(params[:for_id])
    end
  end

  def pull_existing_results_from_cache
    Rails.cache.read(params[:for_id]) if params[:for_id] != "random"
  end

  def augment_asker_if_necessary
    RehydrateAddressService.new.from_citycode!(@asker)
  end

  def create_results_from_asker
    SerializeResultsService.get_instance.go(@asker)
  end

end
