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
      all_activated_aids_json = Aid.activated.to_json(:include => :filters)
      all_filters_json = Filter.all.to_json
      all_contracts_json = ContractType.all.to_json
      all_rules_json = Rule.all.to_json
      activated_models = {}
      activated_models["all_activated_aids"] = _clean_all_activated_aids(JSON.parse(all_activated_aids_json))
      activated_models["all_filters"] = _clean_all_filters(JSON.parse(all_filters_json))
      activated_models["all_contracts"] = _clean_all_contracts(JSON.parse(all_contracts_json))
      activated_models["all_rules"] = _clean_all_rules(JSON.parse(all_rules_json))
      activated_models_json = activated_models.to_json
      CacheService.get_instance.write("activated_models_json", activated_models_json)
    ensure
      @all_activated_models = JSON.parse(activated_models_json)
    end
  end

  def read
    @all_activated_models
  end

  def _clean_all_activated_aids(aids)
    aids.each do |aid|  
      aid.delete("created_at")
      aid.delete("updated_at")
      aid.delete("archived_at")
      aid["filters"].each do |filter| 
        filter.delete("created_at")
        filter.delete("updated_at")
        filter.delete("name")
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

  def _clean_all_rules(rules)
    rules.each do |rule|  
      rule.delete("created_at")
      rule.delete("updated_at")
    end
    rules
  end

end
