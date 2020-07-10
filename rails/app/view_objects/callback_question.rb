class CallbackQuestion < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @asker = hash_for(locals[:asker].attributes.with_indifferent_access)
  end

  def display_duree_d_inscription?
    @asker[:v_inscrit] == "oui" && @asker[:v_duree_d_inscription].blank?
  end


end
