class AidForm < ViewObject

  def after_init(args)
    p '- - - - - - - - - - - - - - args- - - - - - - - - - - - - - - -' 
    pp args.inspect
    p ''
    locals = hash_for(args)
    @page = locals[:page]
    @mandatory_list = ["name", "contract_type_id", "ordre_affichage"]
  end


end
