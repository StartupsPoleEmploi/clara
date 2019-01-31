class AidForm < ViewObject

  def after_init(args)
    p '- - - - - - - - - - - - - - args- - - - - - - - - - - - - - - -' 
    pp args.inspect
    p ''
    locals = hash_for(args)
    @page = locals[:page]
    @mandatory_list = ["name", "contract_type_id", "ordre_affichage"]
    @errors_h = _init_errors_messages(@page)
  end

  def is_in_error(attrib)
    @errors_h.key?(attrib) && @errors_h[attrib].size > 0
  end

  def error_message(attrib)
    @errors_h[attrib][0]
  end

  def _init_errors_messages(page)
    res_h = page.resource.errors.messages
    res_h.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
    res_h
  end

end
