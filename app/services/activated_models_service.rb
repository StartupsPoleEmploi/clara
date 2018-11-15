class ActivatedModelsService
  include Singleton

  def initialize
    regenerate
  end

  def regenerate
    @cached_activated_models = Rails.cache.fetch("activated_models") { Oj.load(File.read(Rails.root.join('public','activated_models.txt'))) }
    @cached_activated_models.is_a?(Hash) && !@cached_activated_models.empty?
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

  def level3_filters
    !Rails.env.test? ? @cached_activated_models["all_level3_filters"] : JsonModelsService.level3_filters
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
