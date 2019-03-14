class Simulation < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end

  def displayed_variables
    variable_1 = OpenStruct.new(
      html_id: "v_handicap", 
      displayed_label: "le handicap",
      form_name: "asker[v_handicap]",
    )
    [variable_1]
  end
end
