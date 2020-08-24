class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @context = locals[:context] if locals[:context]
    @current_path = StringToRouteService.new(@context.request).path
    @larger_container = locals[:larger_container] || "no"
    @margin_constraint = locals[:margin_constraint] || "yes"
  end

  def additional_css
    res = ''
    res += ' u-useful-width--larger' if @larger_container == "yes"
    res += ' u-useful-width--normal' if @larger_container == "no"
    res += ' u-margin-constraint' if @margin_constraint == "yes"
    res
  end

  def display_form?
    return RoutesList.new.asked_questions.keys.include?(@current_path)
  end

  def display_search?
    @current_path == "get_search_front_path"
  end

  def display_results?
    @current_path == "aides_path" && @context.params[:for_id]
  end

  def display_cgu?
    @current_path == "conditions_generales_d_utilisation_path"
  end

  def display_callback?
    @current_path == "peconnect_callback_path"
  end

  def display_confidentiality?
    @current_path == "confidentiality_index_path"
  end

  def display_contact?
    @current_path == "contact_index_path"
  end

  def display_detail?
    @current_path == "detail_path" && @context.params[:for_id]
  end

  def link_to_aides
    "#{aides_path}?for_id=#{@context.params[:for_id]}"
  end

end
