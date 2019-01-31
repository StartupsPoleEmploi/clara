class AidForm < ViewObject

  def after_init(args)
    p '- - - - - - - - - - - - - - args- - - - - - - - - - - - - - - -' 
    pp args.inspect
    p ''
    # locals = hash_for(args)
  end


end
