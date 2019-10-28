class NewAidOne < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @errors_h = _init_errors_messages(@page)
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def show_field?(attribute)
    name = attr_name(attribute)
    ["name", "contract_type", "ordre_affichage", "source"].include?(name)
  end

  def mandatory_field?(attribute)
    name = attr_name(attribute)
    ["name", "contract_type", "ordre_affichage"].include?(name)
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
