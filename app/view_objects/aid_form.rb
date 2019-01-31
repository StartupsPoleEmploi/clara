class AidForm < ViewObject

  def after_init(args)
    p '- - - - - - - - - - - - - - args- - - - - - - - - - - - - - - -' 
    pp args.inspect
    p ''
    locals = hash_for(args)
    @page = locals[:page]
    @mandatory_list = ["name", "contract_type_id", "ordre_affichage"]
    @errors_h = _init_errors_messages(@page)
    @attr_id = @page.resource.attributes["id"].to_s 

  end

  def hide_field?(attribute)
    attr_name(attribute) == "archived_at" && @attr_id.blank?
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def is_in_error(attribute)
    @errors_h.key?(attribute) && @errors_h[attribute].size > 0
  end

  def mandatory?(attr_name)
    @mandatory_list.include?(attr_name)
  end

  def error_message(attribute)
    @errors_h[attribute][0]
  end

  def _init_errors_messages(page)
    res_h = page.resource.errors.messages
    res_h.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
    res_h
  end

end
