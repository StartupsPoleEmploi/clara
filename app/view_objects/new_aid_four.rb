class NewAidFour < NewAidStep

  def after_init(args)
    locals = hash_for(args)
    @aid = locals[:page].resource
    @aid_status = locals[:aid_status]
  end

end
