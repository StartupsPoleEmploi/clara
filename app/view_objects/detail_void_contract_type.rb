class DetailVoidContractType < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
  end

  def list_of_contract_without_current
    ContractType.all.where.not(id: @contract[:id])
  end 

  def links_to_all_contract_types
      list_of_contract_without_current.map do |c| {
        name: c.name,
        link: @context.link_to(c.name, type_path(c.slug), {"class" => "c-link-to-ct"})
      }
      end
  end

  
end
