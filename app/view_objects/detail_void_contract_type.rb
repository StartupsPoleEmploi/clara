class DetailVoidContractType < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @contract = hash_for(locals[:contract])
    puts "contract"
    puts @contract
  end

  def links_to_all_contract_types
    #unless

    #@contract_list = 
      ContractType.all.map do |c|
      {
        name: c.name,
        link: @context.link_to(c.name, type_path(c.slug), {"class" => "c-link-to-ct"})
      }
      end
    #end
  end

  
end
