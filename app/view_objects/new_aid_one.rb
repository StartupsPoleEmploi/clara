class NewAidOne < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @errors_h = _init_errors_messages(@page)
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def show_field?(attribute, role)
    name = attr_name(attribute)
    res = false
    if role == "superadmin"
     res = ["name", "contract_type", "ordre_affichage", "source"].include?(name)
    elsif role == "contributeur" || role == "relecteur"
     res = ["name", "contract_type", "source"].include?(name)
    end
    res
  end


  def mandatory_field?(attribute)
    name = attr_name(attribute)
    ["name", "contract_type", "ordre_affichage"].include?(name)
  end

  def placeholder_of(attribute)
    name = attr_name(attribute)
    {
      "name" => "Exemple : Prépa compétences Occitanie",
      "source" => "Exemple : Pôle emploi, BUDI",
    }[name]
  end

  def small_text_of(attribute)
    name = attr_name(attribute)
    {
      "name" => "Le nom de l'aide ne doit pas comporter d'acronymes et préciser la zone géographique si nécessaire.",
      "source" => "En général, ce sera utile pour le relecteur d'avoir accès à cette source.",
    }[name]
  end

  def error_message(attribute)
    actual_attr = attribute.attribute
    @errors_h[actual_attr][0]
  end

  def errored?(attribute)
    actual_attr = attribute.attribute
    @errors_h.key?(actual_attr) && @errors_h[actual_attr].size > 0
  end

  def _init_errors_messages(page)
    res_h = page.resource.errors.messages
    res_h.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
    res_h
  end

end
