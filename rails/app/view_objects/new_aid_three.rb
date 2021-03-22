class NewAidThree < NewAidStep

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
    @ct = locals[:contract_type]
    @aid_attributes = locals[:aid_attributes]
    @errors_h = _init_errors_messages(@page)
    @aid_status = locals[:aid_status]
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def help_of(attribute)
    name = attr_name(attribute)
    {
      "short_description" => "Décrire en une ligne l'aide, ce résumé apparaît pour l'utilisateur dans les résultats de sa simulation, juste en dessous du nom de l'aide.",
      "filters" => "L'utilisateur retrouvera plus facilement cette aide, s'il applique des filtres après sa simulation; ce champ est différent du champ \"Rubrique\" et sert aux utilisateurs qui veulent voir apparaître moins de résultats, en fonction de ce qu'ils sont venus chercher.",
    }[name]
  end


  def show_field?(attribute)
    name = attr_name(attribute)
    [ "short_description", "filters" ].include?(name)
  end

  def mandatory_field?(attribute)
    false
  end

  def optional_field?(attribute)
    true
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
    res_h.deep_dup.transform_keys! do |key|
      key.to_s.end_with?("_id") ? key.to_s.chars.first(key.size - 3).join.to_sym : key
    end
    res_h
  end

  def svg
    @ct[:icon]
  end

  def aid_name
    @aid_attributes[:name]
  end

  def aid_slug
    @aid_attributes[:slug]
  end

  def contract_type_name
    @ct[:name]
  end

end
