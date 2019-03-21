# deprecated
class ExpireCache

  def call
    Rails.cache.clear
    ActivatedModelsGeneratorService.new.regenerate unless Rails.env.test?
    ActivatedModelsService.instance.regenerate unless Rails.env.test?
  end

end
