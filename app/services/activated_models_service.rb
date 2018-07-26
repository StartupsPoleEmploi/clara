class ActivatedModelsService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def ActivatedModelsService.set_instance(the_double)
    @@the_double = the_double
  end

  def ActivatedModelsService.get_instance
    @@the_double.nil? ? ActivatedModelsService.new : @@the_double
  end

  def initialize
    activated_models_json = CacheService.get_instance.read("activated_models_json")
    begin
      JSON.parse(activated_models_json)
    rescue Exception => e
      all_activated_aids_json = Aid.activated.to_json(:include => [:filters])
      all_filters_json = Filter.all.to_json
      all_contracts_json = ContractType.all.to_json
      all_variables_json = Variable.all.to_json
      all_rules_json = Rule.all.to_json(:include => [:slave_rules])
      all_users_json = User.all.to_json
      activated_models = {}
      activated_models["all_activated_aids"] = _clean_all_activated_aids(JSON.parse(all_activated_aids_json))
      activated_models["all_filters"]        = _clean_all_filters(JSON.parse(all_filters_json))
      activated_models["all_contracts"]      = _clean_all_contracts(JSON.parse(all_contracts_json))
      activated_models["all_rules"]          = _clean_all_rules(JSON.parse(all_rules_json))
      activated_models["all_variables"]      = _clean_all_variables(JSON.parse(all_variables_json))
      activated_models["all_users"]          = _clean_all_users(JSON.parse(all_users_json))
      activated_models_json                  = activated_models.to_json
      CacheService.get_instance.write("activated_models_json", activated_models_json)
    ensure
      @all_activated_models = JSON.parse(activated_models_json)
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

  def users
    @all_activated_models["all_users"]
  end

  def _clean_all_activated_aids(aids)
    aids.each do |aid|  
      aid.delete("created_at")
      aid.delete("updated_at")
      aid.delete("archived_at")
      aid["filters"].map! do |slave_rule|
        slave_rule.select {|k,v| k == "id" }
      end
    end
    aids
  end

  def _clean_all_contracts(contracts)
    contracts.each do |contract|  
      contract.delete("created_at")
      contract.delete("updated_at")
    end
    contracts
  end

  def _clean_all_filters(filters)
    filters.each do |filter|  
      filter.delete("created_at")
      filter.delete("updated_at")
    end
    filters
  end

  def _clean_all_users(users)
    users.each do |user|  
      user.delete("created_at")
      user.delete("updated_at")
    end
    users
  end

  def _clean_all_rules(rules)
    rules.each do |rule|  
      rule.delete("created_at")
      rule.delete("updated_at")
      rule["slave_rules"].map! do |slave_rule|
        slave_rule.select {|k,v| k == "id" }
      end
    end
    rules
  end

  def _clean_all_variables(variables)
    variables.each do |variable|  
      variable.delete("created_at")
      variable.delete("updated_at")
    end
    variables
  end

end
