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

  def get_search_front
      aids_h, total_nb = _aides_index_search
      hydrate_view({
        "aids" => aids_h,
        "total_nb" => total_nb,
      })
  end
  def post_search_front
    extractor = ExtractParam.new(params)
    previous_search = extractor.call(:previous_search)
    current_search = extractor.call(:plain_text_search)
    page_nb = extractor.call(:page_nb)
    redirect_h = {action: "get_search_front"}
    redirect_h[:usearch] = current_search unless current_search.blank?
    if previous_search != current_search
      page_nb = nil
    end
    redirect_h[:page] = page_nb unless page_nb.blank?
    redirect_to redirect_h
  end

  def _aides_index_search
    extractor = ExtractParam.new(params)
    usearch = extractor.call(:usearch)
    page_nb_str = extractor.call(:page)
    page_nb = page_nb_str.blank? ? 1 : page_nb_str.to_i

    aids = nil
    if usearch
      aids = Aid.roughly_spelled_like(usearch).activated
      unless CookiePreference.new(session).ga_disabled?
        TrackSearch.call(user_search: usearch)
      end
    else
      aids = Aid.all.activated
    end
    
    @aids = aids.page(page_nb).per(GetPaginationSearchNumberService.call)
    p '- - - - - - - - - - - - - - @aids- - - - - - - - - - - - - - - -' 
    pp @aids
    p ''
    @h_aids = JSON.parse(@aids.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id, :ordre_affichage ], :include => {filters: {only:[:id, :slug]}, custom_filters: {only:[:id, :slug, :custom_parent_filter_id]}, need_filters: {only:[:id, :slug]}}))
    p '- - - - - - - - - - - - - - @h_aids- - - - - - - - - - - - - - - -' 
    pp @h_aids
    p ''
    return @h_aids, aids.size
  end

  def search_for_aids
    extractor = ExtractParam.new(params)
    previous_search = extractor.call(:previous_search)
    current_search = extractor.call(:plain_text_search)
    page_nb = extractor.call(:page_nb)
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

  def pull_asker
    if (params[:for_id] == 'random')
      @asker = RandomAskerService.new.go
    elsif asker_exists?
      @asker = require_asker
    else
      @asker = TranslateB64AskerService.new.from_b64(params[:for_id])
    end
  end

  def augment_asker_if_necessary
    @asker = HydrateAddress.call(asker_attributes: @asker.attributes)
  end

  def create_results_from_asker
    SerializeResultsService.get_instance.go(@asker)
  end

end
