class FilterFormVo < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @mandatory_list = ["name", "description"]
    @errors_h = _init_errors_messages
    @attr_id = @page.resource.attributes["id"].to_s 
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def errored?(attribute)
    actual_attr = attribute.attribute
    @errors_h.key?(actual_attr) && @errors_h[actual_attr].size > 0
  end

  def mandatory?(attribute)
    @mandatory_list.include?(attr_name(attribute))
  end

  def error_message(attribute)
    actual_attr = attribute.attribute
    @errors_h[actual_attr][0]
  end

  def _init_errors_messages
    @page.resource.errors.messages.deep_dup.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
  end

end
