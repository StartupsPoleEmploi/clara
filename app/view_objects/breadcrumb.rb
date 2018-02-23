class Breadcrumb < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
  end

  def display_form?
    where == "question"
  end

  def display_result?
  end

  def display_detail?
  end

end
