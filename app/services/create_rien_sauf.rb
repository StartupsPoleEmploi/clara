class CreateRienSauf

  def call(uuid, towns, deps, regions)
    geo_rules = []
    towns.try(:each) do |town|
      r = CreateTownRule.new.call(town, uuid)
      geo_rules.push(r)
    end
    deps.try(:each) do |dep|
      r = CreateDepartmentRule.new.call(dep, uuid)
      geo_rules.push(r)
    end
    regions.try(:each) do |region|
      r = CreateRegionRule.new.call(region, uuid)
      geo_rules.push(r)
    end

    rule_geo = nil
    if geo_rules.size == 1
      rule_geo = geo_rules[0]
    else
      rule_geo = 
        Rule.new(name: "r_#{uuid}_box_geo", kind: "composite", composition_type: "or_rule",
                 slave_rules: geo_rules)
    end

    rule_geo
    
  end

end
