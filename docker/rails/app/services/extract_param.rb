class ExtractParam
  def initialize(params)
    @params = params
  end

  def call(param_name)
    @params.extract!(param_name).permit(param_name).to_h[param_name]
  end
end
