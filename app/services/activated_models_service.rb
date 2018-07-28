class ActivatedModelsService
  include Singleton

  def initialize
    @all_activated_models = Rails.cache.fetch("activated_models") do
      Oj.load(File.read(Rails.root.join('public','activated_models.txt')))
    end
  end

  def read
    @all_activated_models
  end

  def rules
    @all_activated_models["all_rules"]
  end

  def aids
    @all_activated_models["all_activated_aids"]
  end

  def filters
    @all_activated_models["all_filters"]
  end

  def contract_types
    @all_activated_models["all_contracts"]
  end

  def variables
    @all_activated_models["all_variables"]
  end

end
