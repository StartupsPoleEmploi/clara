class DetailVoidContractType < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
  end

  def list_of_contract_without_current
    Rails.cache.fetch("all_but_current_contract", expires_in: 1.hour) do
      all_contracts = ActivatedModelsService.instance.contracts.map do |c| { 
        name: c["name"], 
        link: @context.link_to(c["name"], type_path(c["slug"]), {"class" => "c-link-to-ct"})  
      } 
      end
      all_contracts.reject{|ct| ct[:name] == @contract[:name]}
    end 
  end
  
end
