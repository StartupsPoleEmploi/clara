class Simulation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @rule_id = locals[:page].resource[:id]
  end

  def displayed_variables
    vars = ListVariablesOfRule.new.call(@rule_id)
    vars.map do |v|  
      OpenStruct.new(
        html_id: "#{v['name']}", 
        displayed_label: "#{v['name_translation']}",
        form_name: "asker[#{v['name']}]",
      )
    end
  end

  def hide_all?
    activated_models = ActivatedModelsService.instance
    all_rules = activated_models.rules
    found = all_rules.find{|r| @rule_id == r["id"]}
    rule_not_yet_in_cache = !found
    rule_not_yet_in_cache
  end
  
  def controlled_rule_checks
    res = []
    rule_resolver = RuletreeService.new
    rule = Rule.find(@rule_id)
    rule.custom_rule_checks.each do |c|
      local_result = rule_resolver.resolve(rule.id, c.hsh)  
      is_errored = local_result.to_s == c.result.to_s ? false : true
      res << OpenStruct.new(
        id: c.id, 
        name: c.name,
        hsh: c.hsh,
        result: c.result,
        is_errored: is_errored,
      )
    end
    res
  end

end
