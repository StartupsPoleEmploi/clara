class EnrichAskerFromParams

  def call(asker, params)
    asker.v_duree_d_inscription = ExtractSubparam.new.call(params, :inscription_form, :value)
    asker.v_category = ExtractSubparam.new.call(params, :category_form, :value)
    p '- - - - - - - - - - - - - - asker- - - - - - - - - - - - - - - -' 
    pp asker
    p ''
  end

end
