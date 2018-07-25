class WhitelistAidService

  def for_a_detailed_aid(aid)
    return {} unless aid.is_a?(Aid)
    wanted_keys = %w[name what slug short_description how_much additionnal_conditions how_and_when limitations archived_at]
    return aid.attributes.select { |key, _| wanted_keys.include? key }
  end

  def for_a_filter(filter_hash)
    return {} unless filter_hash.is_a?(Hash)
    wanted_keys = %w[name slug description]
    return filter_hash.select { |key, _| wanted_keys.include? key }
  end
  
  def for_aid_in_list(aid_hash)
    a = ActivatedModelsService.get_instance
    return {} unless aid_hash.is_a?(Hash)
    aid_hash["contract_type"] = a.contract_types.find{|c| c["id"] == aid_hash["contract_type_id"] }["slug"] if aid_hash["contract_type_id"].is_a?(Integer) 
    aid_hash["filters"].map!{|f| a.filters.find{|c| c["id"] == f["id"]}["slug"]}
    wanted_keys = %w[name slug short_description contract_type filters]
    return aid_hash.select { |key, _| wanted_keys.include? key }
  end
  
end
