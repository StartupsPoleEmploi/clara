class EnrichAskerFromParams

  def call(asker, params)
    asker.v_duree_d_inscription = _extract_duree_d_inscription(params)
  end

  def _extract_duree_d_inscription(params)
    res = nil
    if params.has_key?(:inscription_form)
      res = params.require(:inscription_form).permit(:value).to_h[:value]
    end
    res
  end

end
