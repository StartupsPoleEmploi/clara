class CallbackQuestion < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @asker = hash_for(locals[:asker].attributes.with_indifferent_access)
  end

  def display_duree_d_inscription?
    @asker[:v_inscrit] == "oui" && @asker[:v_duree_d_inscription].blank?
  end

  def display_category?
    @asker[:v_category].blank?
  end

  def display_alloc?
    @asker[:v_allocation_type].blank?
  end

  def display_montant?
    kind = @asker[:v_allocation_type]
    amount = @asker[:v_allocation_value_min]
    amount.blank? && ['ARE_ASP', 'ASS_AER_APS_AS-FNE'].include?(kind)
  end


end
