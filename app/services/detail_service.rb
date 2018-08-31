
class DetailService

  def initialize(aid)
    @aid = aid
  end

  def hashified_eligibility_and_rules(asker)
    justification_service = JustificationService.new(@aid)
    is_eligible = RuletreeService.new.resolve(@aid.rule.id, asker.attributes)
    root_condition = justification_service.root_condition
    root_rules = justification_service.root_rules.map{|e| e.attributes.slice('name', 'description').symbolize_keys}
    status_array = justification_service.root_rules.map do |r| 
      res = RuletreeService.new.resolve(r.id, asker.attributes)
      {status: res} 
    end
    root_rules = root_rules.map.with_index do |root_rule, index|
      status = status_array[index]
      root_rule = status.merge(root_rule)
    end

    return {
      aid: @aid, 
      is_eligible: is_eligible, 
      root_condition: root_condition, 
      root_rules: root_rules
    }
  end

  def hashified_aid
    return {
      aid: @aid, 
    }
  end
end
