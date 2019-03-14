class Simulation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end

  def displayed_variables
    # ap FindChildRules.new.call(@page.resource[:id])
    vars = ListVariablesOfRule.new.call(@page.resource[:id])
    res = vars.map do |v|  
      OpenStruct.new(
        html_id: "#{v['name']}", 
        displayed_label: "#{v['name_translation']}",
        form_name: "asker[#{v['name']}]",
      )
      # OpenStruct.new(
      #   html_id: "v_handicap", 
      #   displayed_label: "le handicap",
      #   form_name: "asker[v_handicap]",
      # )
    end
    ap res
    variable_1 = OpenStruct.new(
      html_id: "v_handicap", 
      displayed_label: "le handicap",
      form_name: "asker[v_handicap]",
    )
    [variable_1]
    res
  end
end
