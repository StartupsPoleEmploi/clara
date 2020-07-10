class EnrichAskerFromParams

  def call(asker, params)
    asker.v_duree_d_inscription = extract_duree_d_inscription(params)
  end

  def extract_duree_d_inscription(params)
    ExtractParam.new(params).call("inscription_form")
  end

end
