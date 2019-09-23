
class DetailService

  def initialize(aid)
    @aid = aid
    @rules = ActivatedModelsService.instance.rules
    @rule_tree = RuletreeService.new
  end

  def hashified_eligibility_and_rules(asker)

    justification_service = JustificationService.new(@aid)
    is_eligible = @rule_tree.resolve(@aid.rule.id, asker.attributes)
    root_condition = justification_service.root_condition
    root_rules = justification_service.root_rules.map{|e| e.attributes.slice('name', 'description').symbolize_keys}

    status_array = justification_service.root_rules.map do |r| 
      res = @rule_tree.resolve(r.id, asker.attributes)
      {status: res} 
    end

    root_rules = root_rules.map.with_index do |root_rule, index|
      status = status_array[index]
      root_rule = status.merge(root_rule)
    end

    h= {}
    begin
      h = _build_h(@aid.rule.id, asker.attributes)
    rescue StandardError
      h= {}
    end
    
    return {
      aid: @aid, 
      ability_tree: h
    }
  end

  def _build_h(rule_id, asker_attrs)
    actual_rule = @rules.detect{|r| r["id"] == rule_id}
    res = {
      ability: @rule_tree.resolve(rule_id, asker_attrs),
      name: actual_rule["name"],
      description: actual_rule["description"],
      composition_type: actual_rule["composition_type"], 
      slave_rules: [],
    }

    actual_rule["slave_rules"].each do |r|
      res[:slave_rules].push(_build_h(r["id"], asker_attrs))
    end

    return res
  end

  def hashified_aid
    return {
      aid: @aid, 
    }
  end
end
