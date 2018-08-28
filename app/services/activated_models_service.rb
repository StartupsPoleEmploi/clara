class ActivatedModelsService
  include Singleton

  def initialize
    @all_activated_models = Rails.cache.fetch("activated_models") do
      Oj.load(File.read(Rails.root.join('public','activated_models.txt')))
    end
  end

  def rules
    Rails.env.test? ? JSON.parse(Rule.all.to_json(:only => [ :id, :name, :value_eligible, :operator_type, :composition_type, :variable_id, :value_ineligible ], :include => {slave_rules: {only:[:id, :name]}})) : @all_activated_models["all_rules"]
  end

  def aids
    Rails.env.test? ? JSON.parse(Aid.activated.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id ], :include => {filters: {only:[:id, :slug]}})) : @all_activated_models["all_activated_aids"]
  end

  def filters
    Rails.env.test? ? JSON.parse(Filter.all.to_json(:only => [ :id, :slug ])) :  @all_activated_models["all_filters"]
  end

  def contract_types
    Rails.env.test? ? JSON.parse(ContractType.all.to_json(:only => [ :id, :slug ])) :  @all_activated_models["all_contracts"]
  end

  def variables
    Rails.env.test? ? JSON.parse(Variable.all.to_json(:only => [ :id, :name, :variable_type, :description ])) :  @all_activated_models["all_variables"]
  end

end
