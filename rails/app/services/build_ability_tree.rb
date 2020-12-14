class BuildAbilityTree

  def call(page)
    res = {}
    root_rule_id = page.resource.attributes["rule_id"]
    rules = ActivatedModelsService.instance.rules
    if root_rule_id
      begin
        res = _build_h(root_rule_id, rules)
      rescue StandardError
        res = {}
      end
    end
    res
  end

  def _build_h(rule_id, rules)

    actual_rule = rules.detect{|r| r["id"] == rule_id}
    res = {
      name: actual_rule["name"],
      description: actual_rule["description"],
      composition_type: actual_rule["composition_type"], 
      slave_rules: [],
    }

    actual_rule["slave_rules"].each do |r|
      res[:slave_rules].push(_build_h(r["id"], rules))
    end

    return res
  end
  
end
