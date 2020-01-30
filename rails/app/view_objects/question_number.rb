class QuestionNumber < ViewObject

  def after_init(args)
    @asker = _get_asker
  end

  def value
    res = self.public_send('_value_for_' + _current_question)
  end

  def _get_asker
    Asker.new(JSON.parse(@context.session[:asker].to_s))
  end

  def _current_question
    @context.request.path.split("_questions")[0][1..-1]
  end

  def _value_for_inscription
    1
  end

  def _value_for_category
    2
  end

  def _value_for_allocation
    res = 3
    if _isnt_inscrit(@asker)
      res = 2
    end
    res
  end

  def _value_for_are
    res = 4
    if _isnt_inscrit(@asker)
      res = 3
    end
    res
  end

  def _value_for_age
    res = 5
    if _isnt_inscrit(@asker) && _isnt_montant(@asker)
      res = 3
    elsif _isnt_inscrit(@asker) || _isnt_montant(@asker)
      res = 4
    end
    res
  end

  def _value_for_grade
    res = 6
    if _isnt_inscrit(@asker) && _isnt_montant(@asker)
      res = 4
    elsif _isnt_inscrit(@asker) || _isnt_montant(@asker)
      res = 5
    end
    res
  end

  def _value_for_address
    res = 7
    if _isnt_inscrit(@asker) && _isnt_montant(@asker)
      res = 5
    elsif _isnt_inscrit(@asker) || _isnt_montant(@asker)
      res = 6
    end
    res
  end

  def _value_for_other
    res = 8
    if _isnt_inscrit(@asker) && _isnt_montant(@asker)
      res = 6
    elsif _isnt_inscrit(@asker) || _isnt_montant(@asker)
      res = 7
    end
    res
  end

  def _isnt_inscrit(asker)
    is_inscrit = false
    if asker && asker.v_duree_d_inscription
      is_inscrit = asker.v_duree_d_inscription == 'non_inscrit'
    end
    !is_inscrit
  end

  def _isnt_montant(asker)
    is_montant = false
    if asker && asker.v_allocation_type
      is_montant = asker.v_allocation_type == 'ASS_AER_APS_AS-FNE' || asker.v_allocation_type == 'ARE_ASP'
    end
    !is_montant
  end

end
