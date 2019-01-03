class AidesIndex < ViewObject

  def after_init(args)
    locals = hash_for(args)

    p '- - - - - - - - - - - - - - args- - - - - - - - - - - - - - - -' 
    pp args
    p ''
  end

end
