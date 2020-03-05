class IsNotInscrit

  def call(asker)
    res = false
    p '- - - - - - - - - - - - - - IsNotInscrit- - - - - - - - - - - - - - - -' 
    p ''
    p '- - - - - - - - - - - - - - asker- - - - - - - - - - - - - - - -' 
    ap asker
    p ''
    if asker && asker.v_duree_d_inscription
      res = asker.v_duree_d_inscription == 'non_inscrit'
    end
    res
  end

end
