class EligibleLine < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aids =  array_of_hash_for(locals[:aids])
  end

  def ordered_aids
    @aids.sort_by { |aid| aid[:ordre_affichage] || 0 }
  end

end
