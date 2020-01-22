class NewAidTwo < NewAidStep

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @errors_h = _init_errors_messages(@page)
    @aid_status = locals[:aid_status]
  end

  def display_convention?
    if @context.session[:display_convention]
      return false
    else
      @context.session[:display_convention] = "shown_once"
      return true
    end

  end


  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def show_field?(attribute)
    name = attr_name(attribute)
    [ "what", "additionnal_conditions", "how_much", "how_and_when", "limitations" ].include?(name)
  end

  def mandatory_field?(attribute)
    false
  end

  def error_message(attribute)
    actual_attr = attribute.attribute
    @errors_h[actual_attr][0]
  end

  def errored?(attribute)
    actual_attr = attribute.attribute
    @errors_h.key?(actual_attr) && @errors_h[actual_attr].size > 0
  end

  def _init_errors_messages(page)
    res_h = page.resource.errors.messages
    res_h.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
    res_h
  end

end
