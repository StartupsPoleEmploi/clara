class AidShow < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @page = locals[:page]
  end



  def label_of(attr_name)
    {
      "name" => "Nom de l’aide",
      "short_description" => "Résumé de l’aide",
      "contract_type" => "Rubrique associée",
      "ordre_affichage" => "Ordre d'affichage dans la rubrique",
      "filters" => "Filtres sur la page de résultats",
      "source" => "Sources",
      "status" => "Statut",
    }[attr_name].to_s
  end

  def ordered_info_attributes
    res = []
    res << @page.attributes.find{|e| e.attribute == :name}
    res << @page.attributes.find{|e| e.attribute == :short_description}
    res << @page.attributes.find{|e| e.attribute == :contract_type}
    res << @page.attributes.find{|e| e.attribute == :ordre_affichage}
    res << @page.attributes.find{|e| e.attribute == :filters}
    res << @page.attributes.find{|e| e.attribute == :source}
    res << @page.attributes.find{|e| e.attribute == :status}
    res
  end

  def ordered_content_attributes
    res = []
    res << @page.attributes.find{|e| e.attribute == :what}
    res << @page.attributes.find{|e| e.attribute == :how_much}
    res << @page.attributes.find{|e| e.attribute == :additionnal_conditions}
    res << @page.attributes.find{|e| e.attribute == :how_and_when}
    res << @page.attributes.find{|e| e.attribute == :limitations}
    res
  end

  def attr_name(attribute)
    attribute.attribute.to_s
  end

  def errored?(attribute)
    actual_attr = attribute.attribute
    @errors_h.key?(actual_attr) && @errors_h[actual_attr].size > 0
  end

  def mandatory?(attr_name)
    @mandatory_list.include?(attr_name)
  end

  def error_message(attribute)
    actual_attr = attribute.attribute
    @errors_h[actual_attr][0]
  end


end
