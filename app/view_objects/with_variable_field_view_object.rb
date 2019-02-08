class WithVariableFieldViewObject < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @field = locals[:field]
  end

  def all_allowed_options
    input = @field.associated_resource_options.compact
    # element is
    # ["v_location_label",
    #  21,
    #  {"data-kind"=>"string",
    #   "data-elements"=>"",
    #   "data-elements-translation"=>"",
    #   "data-visible"=>false}
    # ]
    output = input
      .select {|element| element[2]["data-visible"] == true} 
      .map {|element| element[2].delete("data-visible");element}
    p '- - - - - - - - - - - - - - output- - - - - - - - - - - - - - - -' 
    pp output.size
    pp output
    p ''
    output
  end
end
