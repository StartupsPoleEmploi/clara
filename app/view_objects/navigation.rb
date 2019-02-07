class Navigation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @resource_name = string_for(locals[:resource_name])
  end

  def hide_resource?
    excluded_list = ['pages', 'variables', 'status']
    excluded_list.include?(@resource_name)
  end

end
