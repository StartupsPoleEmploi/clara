# deprecated
class ExpireCache < ClaraService

  is_callable

  def call
    Rails.cache.clear
    ActivatedModelsGeneratorService.new.regenerate
    ActivatedModelsService.instance.regenerate
  end

end
