class Footer < ViewObject

  def after_init(args)
    _init_splitted_array_of_contract
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
    contracts =  ActivatedModelsService.instance.contracts
    contracts.each_with_index do |ct, indx|  
      if indx < contracts.size / 2 
        @array1.push(ct) 
      end 
      if indx >= contracts.size / 2  
        @array2.push(ct) 
      end     
    end 
  end 


end
