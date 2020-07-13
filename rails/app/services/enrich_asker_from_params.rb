class EnrichAskerFromParams

  def call(asker, params)
    p '- - - - - - - - - - - - - - EnrichAskerFromParams, before- - - - - - - - - - - - - - - -' 
    ap asker
    p ''
    asker.v_duree_d_inscription = ExtractSubparam.new.call(params, :inscription_form, :value)
    asker.v_category = ExtractSubparam.new.call(params, :category_form, :value)
    p '- - - - - - - - - - - - - - EnrichAskerFromParams, after- - - - - - - - - - - - - - - -' 
    ap asker
    p ''
  end

end
