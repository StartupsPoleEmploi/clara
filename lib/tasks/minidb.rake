namespace :minidb do

  def fill_rules_array(rule_id, array_to_fill)
    activated_models = ActivatedModelsService.instance
    current_rule = activated_models.rules.find{|r| rule_id == r["id"]}

    if current_rule["slave_rules"].size > 0
      current_rule["slave_rules"].each do |slave_rule|  
        array_to_fill << slave_rule["id"]
        fill_rules_array(rule_id, array_to_fill)
      end
    end

  end

  task :recreate => :environment do
    if Rails.env.development?
      p "Recreating a minidatabase from production data"

      # Only a few aids
      Aid.where.not(
        slug:[
          "vsi-volontariat-de-solidarite-internationale",
          "volontariat-associatif",
          "autres-frais-derogatoires",
        ]).destroy_all


      # Only a few rules from the few aids
      activated_models = ActivatedModelsService.instance
      root_rules_id = activated_models.aids.map { |aid| aid["rule_id"] }
      # selected_rules = Rule.all.select { |r| root_rules_id.include?(r.id)   }
      p root_rules_id.inspect
      selected_rules = activated_models.rules.select{|r| root_rules_id.include?(r["id"])}
      p selected_rules.size
      p selected_rules
      raw_selected_rules = selected_rules.map { |e| e["id"] }
      p raw_selected_rules
      # fill_rules_array(selected_rules)
    else
      p "Recreate a minidatabase is for development mode only"
    end
  end

end
