class NewAidFive < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end


  def stage_1_ok?
    false
  end

end
