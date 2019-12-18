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
      "source" => "Exemple : une url issue de pole-emploi.fr, budi ou site partenaire...",
    }[name]
  end

  def help_of(attribute)
    name = attr_name(attribute)
    {
      "name" => "Le nom de l'aide ne doit pas comporter d'acronymes et préciser la zone géographique si nécessaire.",
      "source" => "Utile pour le relecteur; permet de dater la source de l'aide; doit être mise à jour si l'aide est modifiée.",
      "contract_type" => 'Une aide est rangée dans une rubrique quand on affiche les résultats aux utilisateurs (par exemple, l\'aide Bon de transport est "rangée" dans la rubrique Aides à la mobilité pour les utilisateurs qui ont fait une simulation).',
      "ordre_affichage" => "Visible dans la page de résultats",
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
