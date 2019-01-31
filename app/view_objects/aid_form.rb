class AidForm < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @mandatory_list = ["name", "contract_type", "ordre_affichage"]
    @errors_h = _init_errors_messages(@page)
    @attr_id = @page.resource.attributes["id"].to_s 

  end

  def additional_label(attribute)
    # "something"
    t("help_for_attr.aid.limitations", default: nil) 
  end

  def hide_field?(attribute)
    attr_name(attribute) == "archived_at" && @attr_id.blank?
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def errored?(attribute)
    actual_attr = attribute.attribute
    @errors_h.key?(actual_attr) && @errors_h[actual_attr].size > 0
  end

  def mandatory?(attr_name)
    @mandatory_list.include?(attr_name)
  end

  def error_message(attribute)
    actual_attr = attribute.attribute
    @errors_h[actual_attr][0]
  end

  def _init_errors_messages(page)
    res_h = page.resource.errors.messages
    res_h.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
    res_h
  end

end
