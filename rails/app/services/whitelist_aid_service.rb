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
    a = ActivatedModelsService.instance
    return {} unless aids.is_a?(Hash)
    if aids["contract_type_id"].is_a?(Integer)
      aids["contract_type"] = a.contracts.find{|c| c["id"] == aids["contract_type_id"] }["slug"]  
    end
    wanted_keys = %w[name slug short_description contract_type filters]
    return aids.select { |key, _| wanted_keys.include? key }
  end
  
end
