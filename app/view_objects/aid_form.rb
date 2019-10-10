class AidForm < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @mandatory_list = ["name", "contract_type", "ordre_affichage"]
    @errors_h = _init_errors_messages(@page)
    @attr_id = @page.resource.attributes["id"].to_s 
    @rules = ActivatedModelsService.instance.rules
  end


  def _build_h(rule_id)

    actual_rule = @rules.detect{|r| r["id"] == rule_id}
    res = {
      name: actual_rule["name"],
      description: actual_rule["description"],
      composition_type: actual_rule["composition_type"], 
      slave_rules: [],
    }

    actual_rule["slave_rules"].each do |r|
      res[:slave_rules].push(_build_h(r["id"]))
    end

    return res
  end

  def ability_tree
    res = {}
    root_rule_id = @page.resource.attributes["rule_id"]
    if root_rule_id
      begin
        res = _build_h(root_rule_id)
      rescue StandardError
        res = {}
      end
    end
    res
  end

  def additional_label(attribute)
    actual_name = attr_name(attribute)
    actual_key = "help_for_attr.aid.#{attr_name(attribute)}"
    actual_translation = t(actual_key, default: "") 
    actual_translation    
  end

  def hide_field?(attribute, role="")
    cond1 = attr_name(attribute) == "archived_at" && @attr_id.blank?
    cond2 = attr_name(attribute) == "custom_filters" && role != "superadmin"
    cond3 = attr_name(attribute) == "need_filters" && role != "superadmin"
    cond1 || cond2 || cond3
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

  def can_add_special_filter(attr)
  end

end
