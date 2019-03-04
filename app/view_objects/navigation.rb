class Navigation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @resource_name = string_for(locals[:resource_name])
  end

  def hide_resource?
    excluded_list = ["users", "explicitations", "pages", "variables", "status", "need_filters", "axle_filters", "domain_filters", "custom_filters", "custom_parent_filters", "filters", "rule_checks"]
    excluded_list.include?(@resource_name)
  end

  def regular_clazz(req)
    current_path = GetCurrentPathService.call(a_request: req)
    state = "inactive"
    "navigation__link navigation__link--#{state}"
  end

  def filter_clazz(req)
    current_path = GetCurrentPathService.call(a_request: req)
    actives_pathes = [
      "admin_get_all_filters_menu_path", 
      "admin_get_custom_filter_menu_path", 
      "admin_get_need_menu_path", 
      "admin_filters_path",
      "admin_filter_path",
      "edit_admin_filter_path",
      "new_admin_filter_path",
      "admin_custom_filters_path",
      "admin_custom_filter_path",
      "edit_admin_custom_filter_path",
      "new_admin_custom_filter_path",
      "admin_custom_parent_filters_path",
      "admin_custom_parent_filter_path",
      "edit_admin_custom_parent_filter_path",
      "new_admin_custom_parent_filter_path",
      "admin_need_filters_path",
      "admin_need_filter_path",
      "edit_admin_need_filter_path",
      "new_admin_need_filter_path",
      "admin_axle_filters_path",
      "admin_axle_filter_path",
      "edit_admin_axle_filter_path",
      "new_admin_axle_filter_path",
      "admin_domain_filters_path",
      "admin_domain_filter_path",
      "edit_admin_domain_filter_path",
      "new_admin_domain_filter_path",
    ]
    state = "inactive"
    state = "active" if actives_pathes.include?(current_path)
    "navigation__link navigation__link--#{state}"
  end

end
