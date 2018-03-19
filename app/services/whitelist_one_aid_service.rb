class WhitelistOneAidService

  def from_aid(aid)
    return {} unless aid.is_a?(Aid)
    wanted_keys = %w[name what slug short_description how_much additionnal_conditions how_and_when limitations archived_at]
    return aid.attributes.select { |key, _| wanted_keys.include? key }
  end
  
end
