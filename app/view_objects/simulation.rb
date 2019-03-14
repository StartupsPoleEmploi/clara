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
  
end
