class AidShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end



  def ordered_info_attributes
    res = []
    res << @page.attributes.find{|e| e.attribute == :name}
    res << @page.attributes.find{|e| e.attribute == :short_description}
    res << @page.attributes.find{|e| e.attribute == :contract_type}
    res << @page.attributes.find{|e| e.attribute == :ordre_affichage}
    res << @page.attributes.find{|e| e.attribute == :filters}
    res << @page.attributes.find{|e| e.attribute == :source}
    res
  end

  def ordered_content_attributes
    res = []
    # res << @page.resource.attributes["what"]
    res
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
