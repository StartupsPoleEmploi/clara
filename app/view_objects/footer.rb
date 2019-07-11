class Footer < ViewObject

  def after_init(args)
    _init_splitted_array_of_contract
  end

  def links_to_all_contract_types 
    Rails.cache.fetch("footer_links", expires_in: 1.hour) do
      ActivatedModelsService.instance.contracts.map do |c| 
        {
          "name" => c["name"],
          "slug" => c["slug"]
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
    links_to_all_contract_types.each_with_index do |ct, indx|  
      if indx < links_to_all_contract_types.size / 2 
        @array1.push(ct) 
      end 
      if indx >= links_to_all_contract_types.size / 2  
        @array2.push(ct) 
      end     
    end 
  end 


end
