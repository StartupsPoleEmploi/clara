class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @context = locals[:context] if locals[:context]
    @current_path = StringToRouteService.new(@context.request).path
  end

  def display_form?
    return RoutesList.asked_questions.keys.include?(@current_path)
  end

  def display_results?
    aides_path_with_user = @current_path == "aides_path" && @context.params[:for_id]
    # eligibility_path = @current_path == "eligible_type_path" || @current_path == "ineligible_type_path" || @current_path == "uncertain_type_path"
    # aides_path_with_user || aides_path_with_user
    aides_path_with_user
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

end
