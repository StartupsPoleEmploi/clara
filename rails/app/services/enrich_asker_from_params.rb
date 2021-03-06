class EnrichAskerFromParams

  def call(asker, params)
    asker.v_duree_d_inscription = ExtractSubparam.new.call(params, :inscription_form, :value) if params[:inscription_form]
    asker.v_category = ExtractSubparam.new.call(params, :category_form, :value) if params[:category_form]
    asker.v_allocation_type = ExtractSubparam.new.call(params, :allocation_form, :type) if params[:allocation_form]
    asker.v_allocation_value_min = ExtractSubparam.new.call(params, :are_form, :minimum_income) if params[:are_form]
  end

end
