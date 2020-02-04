class AllocationNew < ViewObject

  def after_init(args)
    locals = hash_for(args)
  end

  def display_are?
    !_isnt_inscrit(_get_asker)
  end

  def display_ass?
    !_isnt_inscrit(_get_asker)
  end

  def _get_asker
    Asker.new(JSON.parse(@context.session[:asker].to_s))
  end 

  def _isnt_inscrit(asker)
    isnt_inscrit = false
    if asker && asker.v_duree_d_inscription
      isnt_inscrit = asker.v_duree_d_inscription == 'non_inscrit'
    end
    isnt_inscrit
  end

end
