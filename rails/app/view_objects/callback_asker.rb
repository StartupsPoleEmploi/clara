class CallbackAsker < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @asker = hash_for(locals[:asker])
    @meta = hash_for(locals[:meta])
  end

  def prenom
    'prenom'
  end

  def inscription
    'inscr'
  end

  def age
    '42'
  end

  def diplome
    '42'
  end

  def location_label
    'Agen'
  end

  def allocation_type
    'RSA'
  end


end
