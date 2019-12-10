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
    p '- - - - - - - - - - - - - - actual_rule- - - - - - - - - - - - - - - -' 
    pp actual_rule
    p ''
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
    p '- - - - - - - - - - - - - - root_rule_id- - - - - - - - - - - - - - - -' 
    pp root_rule_id
    p ''
    if root_rule_id
      begin
        res = _build_h(root_rule_id)
      rescue StandardError
        p '- - - - - - - - - - - - - - StandardError- - - - - - - - - - - - - - - -' 
        pp res
        p ''
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

  def hide_field?(attribute, role = "", path = "", email = "")
    a = attr_name(attribute)
    cond1, cond2, cond3 = false
    if a == "archived_at"
      current_aid =  @page.resource
      self_created = current_aid.try(:versions).try(:first).try(:whodunnit) == email
      cond1 = path != "edit_admin_aid_path" || (role != "superadmin" && self_created)
    end
    if a == "custom_filters"
      cond2 = role != "superadmin"
    end 
    if a == "need_filters"
      cond3 = role != "superadmin"
    end 
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

end
