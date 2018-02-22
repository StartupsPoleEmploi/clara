class ContractTypeService
  

  def hashify_category_aides
    ContractType.aides.map{|e| e.attributes}
  end

  def hashify_category_dispositifs
    ContractType.dispositifs.map{|e| e.attributes}
  end

  def slug_of_projet_pro
    generate_slug('projet-pro')
  end

  def slug_of_amob
    generate_slug('amob')
  end

  def slug_of_alternance
    generate_slug('alternance')
  end

  def slug_of_creation_reprise_entreprise
    generate_slug('creation-reprise-entreprise')
  end

private 

  def generate_slug(business_id)
    found = ContractType.find_by(business_id: business_id)
    if found
      return found.slug
    else
      return "not_found"
    end
  end


end
