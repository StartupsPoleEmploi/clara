class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @context = locals[:context] if locals[:context]
  end

  def display_form?
    current_path = StringToRouteService.new(@context.request).path
    return RoutesList.asked_questions.include?(current_path)
  end

  def display_result?
    @context.request.path == aides_path && @context.params[:for_id]
  end

  def display_detail?
  end

end
