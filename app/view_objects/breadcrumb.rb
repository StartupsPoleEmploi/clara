class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @context = locals[:context] if locals[:context]
  end

  def current_path(options = {})
    options = @context.request.params.symbolize_keys.merge(options)
    @context.url_for(Rails.application.routes.recognize_path(@context.request.path).merge(options))
  end

  def display_form?
    current_path = StringToRoute.new(@context.request).path
    return RoutesList.get_questions.include?(current_path)
  end

  def display_result?
    @context.request.path == aides_path && @context.params[:for_id]
  end

  def display_detail?
  end

end
