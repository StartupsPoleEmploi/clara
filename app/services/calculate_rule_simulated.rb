class CalculateRuleSimulated

  def call(rule)
    res = ""
    if (rule.is_a?(Rule))
      all_crc = rule.custom_rule_checks.map{|e| e.attributes}
      has_eligible_simulation = all_crc.any? { |e| e["result"] == "eligible"  }
      has_ineligible_simulation = all_crc.any? { |e| e["result"] == "ineligible"  }
      if has_errored_simulation(rule)
        res = "errored_simulation"
      elsif has_eligible_simulation && has_ineligible_simulation
        res = "ok"
      elsif !has_eligible_simulation && !has_ineligible_simulation
        res = "missing_simulation"
      elsif has_eligible_simulation && !has_ineligible_simulation
        res = "missing_ineligible"
      elsif !has_eligible_simulation && has_ineligible_simulation
        res = "missing_eligible"
      end
    end
    return res
  end

  def has_errored_simulation(rule)
    rule_resolver = RuletreeService.new
    rule.custom_rule_checks.any? do |c|
      local_result = rule_resolver.resolve(rule.id, c.hsh)  
      p '- - - - - - - - - - - - - - c- - - - - - - - - - - - - - - -' 
      ap c
      ap local_result.to_s
      ap c.result.to_s
      p ''
      local_result.to_s != c.result.to_s
    end
  end
  
end
