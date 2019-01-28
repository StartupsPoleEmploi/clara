namespace :minidb do

  def fill_rules_array(rule_id, array_to_fill, all_rules)
    return if array_to_fill.include?(rule_id) 
    array_to_fill << rule_id
    current_rule = all_rules.find{|r| rule_id == r["id"]}

    if current_rule["slave_rules"].size > 0
      current_rule["slave_rules"].each do |slave_rule|
        fill_rules_array(slave_rule["id"], array_to_fill, all_rules)
      end
    end
  end

  task :recreate => :environment do
    if Rails.env.development?
      p "Recreating a minidatabase from production data"
      activated_models = ActivatedModelsService.instance
      all_rules = activated_models.rules

      # Only a few aids
      Aid.where.not(
        slug:[
          "garantie-jeunes",
          "service-militaire-volontaire-smv",
          "vsi-volontariat-de-solidarite-internationale",
          "volontariat-associatif",
          "autres-frais-derogatoires",
          "erasmus",
          "aide-a-la-mobilite-professionnelle-des-artistes-et-technicien-ne-s-du-spectacle",
          "aide-aux-depenses-de-sante-des-artistes-et-technicien-ne-s-du-spectacle",
          "autres-aides-nationales-pour-la-mobilite",
        ]).destroy_all


      # Only a few rules from the few aids
      root_rules_id = activated_models.aids.map { |aid| aid["rule_id"] }
      array_of_searched_rules = []
      root_rules_id.each do |root_rule_id|
        fill_rules_array(root_rule_id, array_of_searched_rules, all_rules)
      end
      p array_of_searched_rules
      ActiveRecord::Base.connection.disable_referential_integrity do
        Rule.where.not(id: array_of_searched_rules).destroy_all
      end
      # fill_rules_array(selected_rules)
    else
      p "Recreate a minidatabase is for development mode only"
    end
  end

end
