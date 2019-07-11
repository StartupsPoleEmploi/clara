class Footer < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aides = array_for(locals[:aides])
    @dispositifs = array_for(locals[:dispositifs])
    _init_splitted_array_of_contract
  end

  def links_to_all_contract_types 
    Rails.cache.fetch("footer_links", expires_in: 1.hour) do
      ActivatedModelsService.instance.contracts.map do |c| 
        { 
          name: c["name"], 
          link: @context.link_to(c["name"], type_path(c["slug"]), {"class" => "c-link-to-ct"})  
        } 
      end
    end 
  end

  def first_part_of_contract_type  
    @array1 
  end   

  def second_part_of_contract_type 
    @array2 
  end

  def _init_splitted_array_of_contract 
    @array1 = []  
    @array2 = []  
    links_to_all_contract_types.each_with_index do |ct, n|  
      if n < links_to_all_contract_types.size / 2 
        @array1.push(ct[:link]) 
      end 
      if n >= links_to_all_contract_types.size / 2  
        @array2.push(ct[:link]) 
      end     
    end 
  end 


end
