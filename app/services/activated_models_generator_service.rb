class ActivatedModelsGeneratorService

  def regenerate
    all_activated_aids_json = Aid.activated.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id ], :include => {filters: {only:[:id, :slug]}})
    all_filters_json = Filter.all.to_json(:only => [ :id, :slug ])
    all_contracts_json = ContractType.all.to_json(:only => [ :id, :slug ])
    all_variables_json = Variable.all.to_json(:only => [ :id, :name, :variable_type, :description ])
    r_all = JSON.parse(Rule.all.to_json(:only => [ :id, :name, :value_eligible, :operator_type, :composition_type, :variable_id, :value_ineligible ], :include => {slave_rules: {only:[:id, :name]}}))
    all_rules = r_all.map{|h| HashService.new.recursive_compact(h)}
    all_users_json = User.all.to_json(:only => [ :id, :email ])
    activated_models = {}
    activated_models["all_activated_aids"] = JSON.parse(all_activated_aids_json)
    activated_models["all_filters"]        = JSON.parse(all_filters_json)
    activated_models["all_contracts"]      = JSON.parse(all_contracts_json)
    activated_models["all_rules"]          = all_rules
    activated_models["all_variables"]      = JSON.parse(all_variables_json)

    # Icky, but works in a reasonable concurrent env
    File.open(Rails.root.join('public','activated_models.txt'), 'w:UTF-8') do |file| 
      file.write(activated_models.to_json) 
    end
    activated_models
  end

end
