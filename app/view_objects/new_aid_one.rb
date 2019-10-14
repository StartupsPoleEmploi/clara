class NewAidOne < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def show_field?(attribute)
    name = attr_name(attribute)
    ap name
    ["name", "contract_type", "ordre_affichage", "source"].include?(name)
  end

end
