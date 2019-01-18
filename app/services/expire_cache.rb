# deprecated
class ExpireCache < ClaraService

  is_callable

  def call
    Rails.cache.clear
    ActivatedModelsGeneratorService.new.regenerate unless Rails.env.test?
    ActivatedModelsService.instance.regenerate unless Rails.env.test?
  end

end
