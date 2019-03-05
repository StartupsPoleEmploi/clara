class CalculateRuleStatus

  def call(rule)
    res = ""
    if (rule.is_a?(Rule))
      all_crc = rule.custom_rule_checks.map{|e| e.attributes}
      has_eligible_simulation = all_crc.any? { |e| e["result"] == "eligible"  }
      has_ineligible_simulation = all_crc.any? { |e| e["result"] == "ineligible"  }
      if has_eligible_simulation && has_ineligible_simulation
        res = "ok"
      end
      if !has_eligible_simulation && !has_ineligible_simulation
        res = "missing_simulation"
      end
      if has_eligible_simulation && !has_ineligible_simulation
        res = "missing_ineligible"
      end
      if !has_eligible_simulation && has_ineligible_simulation
        res = "missing_eligible"
      end
    end
    return res
  end
  
end
