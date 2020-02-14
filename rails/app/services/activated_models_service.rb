class ActivatedModelsService
  include Singleton

  def initialize
    regenerate unless Rails.env.test?
  end

  def regenerate
    @cached_activated_models =  Oj.load(File.read(Rails.root.join('public','activated_models.txt'))) 
  end

  def tracings
    !Rails.env.test? ? @cached_activated_models["all_tracings"] : JsonModelsService.tracings
  end

  def rules
    !Rails.env.test? ? @cached_activated_models["all_rules"] : JsonModelsService.rules
  end

  def aids
    !Rails.env.test? ? @cached_activated_models["all_activated_aids"] : JsonModelsService.aids
  end

  def filters
    !Rails.env.test? ? @cached_activated_models["all_filters"] : JsonModelsService.filters
  end

  def contracts
    !Rails.env.test? ? @cached_activated_models["all_contracts"] : JsonModelsService.contracts
  end

  def variables
    !Rails.env.test? ? @cached_activated_models["all_variables"] : JsonModelsService.variables
  end

end
