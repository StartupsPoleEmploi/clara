class Footer < ViewObject

  def after_init(args)
    locals = hash_for(args)
    @aides = array_for(locals[:aides])
    @dispositifs = array_for(locals[:dispositifs])
    @the_request = locals[:the_request]
  end

  def type_aides
    @aides
  end

  def should_display_footer
    @the_request.respond_to?('path') && !@the_request.path.include?("/stats")
  end

  def link_to_all_aides
    @context.link_to("Toutes nos aides", aides_path, {"class" => "c-link-to-all-aides"})
  end

  def type_dispositifs
    @dispositifs
  end

  def display_title_aides
    @aides.size > 0
  end

  def display_title_dispositifs
    @dispositifs.size > 0
  end

  def links_to_all_contract_types 
    ActivatedModelsService.instance.contracts.map do |c| { 
      name: c["name"], 
      link: @context.link_to(c["name"], type_path(c["slug"]), {"class" => "c-link-to-ct"})  
    } 
    end 
  end 

   def number_of_contract_types 
    links_to_all_contract_types.size  
  end 

   def splitted_array_of_contract 
    @array1 = []  
    @array2 = []  
    links_to_all_contract_types.each_with_index do |ct, n|  
      if n < links_to_all_contract_types.size/2 
        @array1.push(ct[:link]) 
      end 
      if n >= links_to_all_contract_types.size/2  
        @array2.push(ct[:link]) 
      end     
    end 
  end 

   def first_part_of_contract_type  
    @array1 
  end   

   def second_part_of_contract_type 
    @array2 
  end

end
