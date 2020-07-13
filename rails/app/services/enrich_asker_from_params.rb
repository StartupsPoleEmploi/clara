class EnrichAskerFromParams

  def call(asker, params)
    asker.v_duree_d_inscription = ExtractSubparam.new.call(params, :inscription_form, :value) if params[:inscription_form]
    asker.v_category = ExtractSubparam.new.call(params, :category_form, :value) if params[:category_form]
  end

end
