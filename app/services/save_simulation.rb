class SaveSimulation

  def call(given_id, asker_params, simulation_params)
    res = {}
    current_rule = Rule.find(given_id)
    asker_params_cleaned = asker_params.reject{|_, v| v.blank?}
    asker_hash = Asker.new(asker_params_cleaned).attributes
    custom_rule_check = CustomRuleCheck.new
    custom_rule_check.rule = current_rule
    custom_rule_check.name = simulation_params[:name]
    custom_rule_check.result = simulation_params[:result]
    custom_rule_check.hsh = asker_hash
    creation_of_crc_worked = custom_rule_check.save
    if creation_of_crc_worked
      actual_status = CalculateRuleStatus.new.call(current_rule)
      Rule.where(id: current_rule.id).update_all(status: actual_status)
      res[:json] = ["ok"]
      res[:status] = :created
    else
      res[:json] = ["error"]
      res[:status] = :unprocessable_entity
    end
    res
  end
  
end
