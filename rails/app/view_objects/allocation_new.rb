class AllocationNew < ViewObject

  def after_init(args)
    locals = hash_for(args)
  end

  def display_are?
    _is_inscrit
  end

  def display_ass?
    _is_inscrit
  end

  def _is_inscrit
    !IsNotInscrit.new.call(ExtractAskerFromSession.new.call(@context))
  end

end
