class AidesIndex < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @request = @context.request
    @total_nb = integer_for(locals[:total_nb])
  end

  def has_user
    !@request.query_parameters["for_id"].blank?
  end

  def title
    if has_user
      "Vos résultats"
    elsif !@request.query_parameters["usearch"].blank?
      page_nb = @request.query_parameters["page"].blank? ? "1" : @request.query_parameters["page"]
      total_nb = @total_nb
      divided = total_nb.to_f / GetPaginationSearchNumberService.call.to_f
      divided_floor = (total_nb / GetPaginationSearchNumberService.call).floor
      max_page = divided_floor == divided ? divided_floor : divided_floor + 1
      "Résultat de recherche – #{total_nb} aides et mesures sont disponibles - page #{page_nb} sur #{max_page}"
    else
      "Découvrez toutes les aides et mesures de retour à l'emploi"
    end
  end

  def description
    if has_user
      "Vos résultats"
    else
      "Découvrez toutes les aides et mesures de retour à l'emploi"
    end    
  end

end
