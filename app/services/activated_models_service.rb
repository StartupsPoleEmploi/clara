class ActivatedModelsService
  include Singleton
  

  def initialize
    @all_activated_models = Rails.cache.fetch("activated_models") do
      all_activated_aids_json = Aid.activated.to_json(:only => [ :id, :rule_id, :contract_type_id ], :include => {filters: {only:[:id]}})
        # { only: [:first_name, :last_name, :email]}
        # Aid.first.to_json(:only => [ :id, :name ], :include => [:filters])
        # Aid.first.to_json(:only => [ :id, :name ], :include => {:filters, only: [:slug]})
        # Aid.first.to_json(:only => [ :name ], :include => {filters: {only:[:slug]}})

      all_filters_json = Filter.all.to_json(:only => [ :id ])
      all_contracts_json = ContractType.all.to_json(:only => [ :id ])
      all_variables_json = Variable.all.to_json(:only => [ :id, :name, :variable_type, :description ])
      r_all = JSON.parse(Rule.all.to_json(:only => [ :id, :value_eligible, :operator_type, :composition_type, :variable_id, :value_ineligible ], :include => {slave_rules: {only:[:id]}}))
      all_rules = r_all.map{|h| HashService.new.recursive_compact(h)}
      all_users_json = User.all.to_json(:only => [ :email ])
      activated_models = {}
      activated_models["all_activated_aids"] = JSON.parse(all_activated_aids_json)
      activated_models["all_filters"]        = JSON.parse(all_filters_json)
      activated_models["all_contracts"]      = JSON.parse(all_contracts_json)
      activated_models["all_rules"]          = all_rules
      activated_models["all_variables"]      = JSON.parse(all_variables_json)
      activated_models["all_users"]          = JSON.parse(all_users_json)
      p '- - - - - - - - - - - - - - activated_models- - - - - - - - - - - - - - - -' 
      pp activated_models
      p ''
      activated_models
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
      aid.delete("what")
      aid.delete("short_description")
      aid.delete("how_much")
      aid.delete("additionnal_conditions")
      aid.delete("limitations")
      aid.delete("how_and_when")
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
