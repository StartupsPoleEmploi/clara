class WithVariableFieldViewObject < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @field = locals[:field]

  end

end
