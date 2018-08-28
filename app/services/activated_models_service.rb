class ActivatedModelsService
  include Singleton

  def initialize
    @all_activated_models = Rails.cache.fetch("activated_models") do
      Oj.load(File.read(Rails.root.join('public','activated_models.txt')))
    end
  end

  def rules
    Rails.env.test? ? JSON.parse(Rule.all.to_json) : @all_activated_models["all_rules"]
  end

  def aids
    Rails.env.test? ? JSON.parse(Aid.activated.to_json) : @all_activated_models["all_activated_aids"]
  end

  def filters
    Rails.env.test? ? JSON.parse(Filter.all.to_json) :  @all_activated_models["all_filters"]
  end

  def contract_types
    Rails.env.test? ? JSON.parse(ContractType.all.to_json) :  @all_activated_models["all_contracts"]
  end

  def variables
    Rails.env.test? ? JSON.parse(Variable.all.to_json) :  @all_activated_models["all_variables"]
  end

end
