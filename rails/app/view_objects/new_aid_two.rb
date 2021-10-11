class NewAidTwo < NewAidStep


  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @aid_status = locals[:aid_status]
  end

  def display_convention?
    @context.session["init"] = true # HACK : force to load session here
    @context.session[:hide_convention] == nil
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def show_field?(attribute)
    name = attr_name(attribute)
    [ "what", "additionnal_conditions", "how_much", "how_and_when", "limitations" ].include?(name)
  end

end
