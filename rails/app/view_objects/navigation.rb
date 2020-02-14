class Navigation < ViewObject
  
  def admin_clazz
    current_path = GetCurrentPathService.new(@context.request).call
    actives_pathes = [
      "admin_get_hidden_admin_path", 
      "admin_get_cache_path", 
      "admin_get_zrr_path", 
      "admin_explicitations_path", 
      "admin_variables_path", 
      "admin_get_stats_path", 
      "admin_api_users_path", 
      "admin_users_path", 
      "admin_tracings_path", 
      "admin_traces_path", 
    ]
    state = "inactive"
    state = "active" if actives_pathes.include?(current_path)
    "navigation__link navigation__link--#{state}"
  end

  def filter_clazz
    current_path = GetCurrentPathService.new(@context.request).call
    actives_pathes = [
      "admin_get_custom_filter_menu_path", 
      "admin_filters_path",
      "admin_filter_path",
      "edit_admin_filter_path",
      "new_admin_filter_path",
    ]
    state = "inactive"
    state = "active" if actives_pathes.include?(current_path)
    "navigation__link navigation__link--#{state}"
  end

end
