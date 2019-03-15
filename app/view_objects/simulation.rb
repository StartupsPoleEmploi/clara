class Simulation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end

  def displayed_variables
    vars = ListVariablesOfRule.new.call(@page.resource[:id])
    vars.map do |v|  
      OpenStruct.new(
        html_id: "#{v['name']}", 
        displayed_label: "#{v['name_translation']}",
        form_name: "asker[#{v['name']}]",
      )
    end
  end

  def hide_all?
    rule_id = @page.resource[:id]
    activated_models = ActivatedModelsService.instance
    all_rules = activated_models.rules
    found = all_rules.find{|r| rule_id == r["id"]}
    rule_not_yet_in_cache = !found
    rule_not_yet_in_cache
  end
  
end
