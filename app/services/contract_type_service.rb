class ContractTypeService
  

  def hashify_category_aides
    ContractType.aides.map{|e| e.attributes}
  end

  def hashify_category_dispositifs
    ContractType.dispositifs.map{|e| e.attributes}
  end

  def slug_of_projet_pro
    generate_slug('aide-a-la-definition-du-projet-professionnel')
  end

  def slug_of_amob
    generate_slug('aide-a-la-mobilite')
  end

  def slug_of_alternance
    generate_slug('contrat-en-alternance')
  end

  def slug_of_creation_reprise_entreprise
    generate_slug('aide-a-la-creation-ou-reprise-d-entreprise')
  end

private 

  def generate_slug(a_slug)
    found = ContractType.find_by(slug: a_slug)
    if found
      return found.slug
    else
      return "not_found"
    end
  end


end
