class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    @ability = string_for(locals[:ability])
    @context = locals[:context] if locals[:context]
    @current_path = StringToRouteService.new(@context.request).path
  end

  def display_form?
    return RoutesList.asked_questions.keys.include?(@current_path)
  end

  def display_results?
    @current_path == "aides_path" && @context.params[:for_id]
  end

  def display_results_per_type?
    @current_path == "eligible_type_path" || @current_path == "ineligible_type_path" || @current_path == "uncertain_type_path"
  end

  def display_contact?
    @current_path == "contact_index_path"
  end

  def display_detail?
    @current_path == "detail_path" && @context.params[:for_id]
  end

  def display_print?
    @current_path == "detail_path" ||  (@current_path == "aides_path" && !!@context.params[:for_id])
  end

  def link_to_aides
    "#{aides_path}?for_id=#{@context.params[:for_id]}"
  end

  def link_to_aides_pertype
    res = "#{aides_path}?for_id=#{@context.params[:for_id]}"
    if @ability == "eligible"
      res = "#{eligible_type_path}?for_id=#{@context.params[:for_id]}"
    elsif @ability == "uncertain"
      res = "#{uncertain_type_path}?for_id=#{@context.params[:for_id]}"
    elsif @ability == "ineligible"
      res = "#{ineligible_type_path}?for_id=#{@context.params[:for_id]}"
    end
      
  end

  def pertype
    @contract[:name]
  end

end
