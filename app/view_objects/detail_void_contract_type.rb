class DetailVoidContractType < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
  end

  def list_of_contract_without_current
    all_contracts = ActivatedModelsService.instance.contracts.map do |c| { 
      name: c["name"], 
      link: @context.link_to(c["name"], type_path(c["slug"]), {"class" => "c-link-to-ct"})  
    } 
    end
    res = all_contracts.reject{|ct| ct[:name] == @contract[:name]}
    res
  end 
  
end
