class RuleCheckService
  include Rails.application.routes.url_helpers

  def check_type(rule)
    state = 'error'
    if rule.variable.present?
      if rule.variable.variable_type == 'integer'
        state='ok' if !!( rule.value_eligible.match /^(\d)+$/ )
      elsif rule.variable.variable_type == 'string'
        array_of_possibilities = rule.variable.description.split(',').map {|e| e.strip}
        if array_of_possibilities.include?(rule.value_eligible)
          state='ok'
        end
      else
        state='error'
      end
    else
      state='n/a'
    end
    state
  end
  
  def check_custom_rule(rule, all_rules_composition)
    rule.custom_rule_checks.each do |c|
      local_result = rule.resolve(c.hsh)  
      final_result = local_result.to_s == c.result.to_s ? 'ok' : 'error'
      all_rules_composition << { type: '3-custom', name: rule.name, result: final_result, link: edit_admin_rule_path(rule.id), description: c.name }
    end
  end


  
end
