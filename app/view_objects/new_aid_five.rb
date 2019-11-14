class NewAidFive < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end


end
