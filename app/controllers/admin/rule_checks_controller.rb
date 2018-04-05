module Admin
  class RuleChecksController < Admin::ApplicationController

    def index
      all_rules = Rule.all
      @all_rules_composition = []
      all_rules.each do |one_rule|
      typecheck = RuleCheckService.new.check_type(one_rule)
      @all_rules_composition << { type: '2-type', name: one_rule.name, result: typecheck, link: edit_admin_rule_path(one_rule.id) }
      typecheck = RuleCheckService.new.check_custom_rule(one_rule, @all_rules_composition)
      end
      @all_rules_composition = @all_rules_composition.sort_by { |hsh| hsh[:type] }
    end

  end
end
