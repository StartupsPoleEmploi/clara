class ActivatedModelsService
  include Singleton

  def initialize
    regenerate
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

  def need_filters
    !Rails.env.test? ? @cached_activated_models["all_need_filters"] : JsonModelsService.need_filters
  end

  def custom_filters
    !Rails.env.test? ? @cached_activated_models["all_custom_filters"] : JsonModelsService.custom_filters
  end

  def custom_parent_filters
    !Rails.env.test? ? @cached_activated_models["all_custom_parent_filters"] : JsonModelsService.custom_parent_filters
  end

  def contracts
    !Rails.env.test? ? @cached_activated_models["all_contracts"] : JsonModelsService.contracts
  end

  def variables
    !Rails.env.test? ? @cached_activated_models["all_variables"] : JsonModelsService.variables
  end

end
