class NewAidFive < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end


  def stage_1_ok?
    false
  end

  def stage_2_ok?
    true
  end

  def stage_3_ok?
    false
  end

  def stage_4_ok?
    false
  end

end
