class Navigation < ViewObject

  def after_init(args)
    locals = hash_for(args)
  end

  def filter_clazz(req)
    current_path = GetCurrentPathService.new(req).call
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
