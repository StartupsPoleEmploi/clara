class DetailVoidContractType < ViewObject

  def after_init(args)
    @name = "Aide à la mobilité" 
  end

  def links_to_all_contract_types
    #unless
      ContractType.all.map do |c|
      {
        name: c.name,
        link: @context.link_to(c.name, type_path(c.slug), {"class" => "c-link-to-ct"})
      }
      end
    #end
  end

  
end
