class ResultList < ViewObject

  def after_init(args)
    locals     = hash_for(args)
    @clazz = string_for(args[:clazz])
    @lines = array_for(args[:lines])
    @strong_title = string_for(args[:strong_title])
  end

  def css_root
    "c-result-list--#{@clazz}"
  end

  def clazz
    @clazz
  end

  def ordered_lines
    @lines.sort_by{|line| line['order']}
  end

  def strong_title
    @strong_title
  end

end
