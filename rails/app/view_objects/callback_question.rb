class CallbackQuestion < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @where = string_for(locals[:where])
    @asker = hash_for(locals[:asker])
  end

  def display_duree_d_inscription?
  end

  def display_category?
  end

end