class WhitelistAidService

  def for_a_detailed_aid(aid)
    return {} unless aid.is_a?(Aid)
    wanted_keys = %w[name what slug short_description how_much additionnal_conditions how_and_when limitations archived_at]
    return aid.attributes.select { |key, _| wanted_keys.include? key }
  end
  
  def for_aid_in_list(aid_hash)
    return {} unless aid_hash.is_a?(Hash)
    wanted_keys = %w[name slug short_description contract_type_business_id contract_type_description]
    return aid_hash.select { |key, _| wanted_keys.include? key }
  end
  
end
