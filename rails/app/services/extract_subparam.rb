class ExtractSubparam

  def call(params, parent_param, param)
    res = nil
    if params.has_key?(parent_param)
      res = params.require(parent_param).permit(param).to_h[param]
    end
    res

  end
end
