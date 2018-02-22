class Footer < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aides = array_for(locals[:aides])
    @dispositifs = array_for(locals[:dispositifs])
    @the_request = locals[:the_request]
  end

  def type_aides
    @aides
  end

  def current_mode
    @the_request.path == root_path ? 'home' : 'not_home'
  end

  def link_to_all_aides
    @context.link_to("Toutes nos aides", aides_path, {"class" => "c-link-to-all-aides__#{current_mode}"})
  end

  def type_dispositifs
    @dispositifs
  end

  def display_title_aides
    @aides.size > 0
  end

  def content_css
    "c-footer__content--aides_#{current_mode}"
  end

  def display_title_dispositifs
    @dispositifs.size > 0
  end

end
