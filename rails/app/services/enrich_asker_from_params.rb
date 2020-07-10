class EnrichAskerFromParams

  def call(asker, params)
    asker.v_duree_d_inscription = ExtractSubparam.new.call(params, :inscription_form, :value)
  end

end
