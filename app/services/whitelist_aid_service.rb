class WhitelistAidService

  def for_a_detailed_aid(single_aid_as_hash)
    return {} unless single_aid_as_hash.is_a?(Hash)
    wanted_keys = %w[name what slug short_description how_much additionnal_conditions how_and_when limitations archived_at]
    return single_aid_as_hash.select { |key, _| wanted_keys.include? key }
  end

  def for_a_filter(filter_hash)
    return {} unless filter_hash.is_a?(Hash)
    wanted_keys = %w[name slug description]
    return filter_hash.select { |key, _| wanted_keys.include? key }
  end
  
  def for_aid_in_list(aid_hash)
    aids = aid_hash.deep_dup
    # p '- - - - - - - - - - - - - - aids- - - - - - - - - - - - - - - -' 
    # pp aids
    # p ''
    a = ActivatedModelsService.instance
    return {} unless aids.is_a?(Hash)
    if aids["contract_type_id"].is_a?(Integer)
      aids["contract_type"] = a.contracts.find{|c| c["id"] == aids["contract_type_id"] }["slug"]  
    end
    # if aids["filters"].is_a?(Array) && !aids["filters"].empty?
    #   aids["filters"].map!{|f| a.filters.find{|c|  c["id"] == f["id"]}}
    # end
    # if aids["level3_filters"].is_a?(Array) && !aids["level3_filters"].empty?
    #   aids["level3_filters"].map!{|f| a.level3_filters.find{|c|  c["id"] == f["id"]}}
    # end
    if aids["custom_filters"].is_a?(Array) && !aids["custom_filters"].empty?
      # aids["custom_filters"].map!{|f| a.custom_filters.find{|c|  c["id"] == f["id"]}}
      # p '- - - - - - - - - - - - - - BEFORE aids["custom_filters"]- - - - - - - - - - - - - - - -' 
      # pp aids["custom_filters"]
      # p ''
      aids["custom_filters"].map! do |f| 
        parent = a.custom_parent_filters.find{|c|  c["id"] == f["custom_parent_filter_id"]}
        {"slug" => f["slug"], "parent_slug" => parent["slug"]}
      end
      # p '- - - - - - - - - - - - - - AFTER aids["custom_filters"]- - - - - - - - - - - - - - - -' 
      # pp aids["custom_filters"]
      # p ''
    end
    wanted_keys = %w[name slug short_description contract_type filters level3_filters custom_filters custom_parent_filters]
    # p '- - - - - - - - - - - - - - aids- - - - - - - - - - - - - - - -' 
    # pp aids
    # p ''

    return aids.select { |key, _| wanted_keys.include? key }
  end
  
end
