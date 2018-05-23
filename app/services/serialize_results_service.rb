
class SerializeResultsService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def SerializeResultsService.set_instance(the_double)
    @@the_double = the_double
  end

  def SerializeResultsService.get_instance
    @@the_double.nil? ? SerializeResultsService.new : @@the_double
  end

  def go(asker)
    res = {
     flat_all_eligible: displayable_hash(all_eligible(asker)),
     flat_all_uncertain: displayable_hash(all_uncertain(asker)),
     flat_all_ineligible: displayable_hash(all_ineligible(asker)),
     asker: asker.attributes
    }
    res
  end

  def jsonify_eligible(asker)
    result = {
      asker: asker.attributes,
      aids: whitelist(displayable_hash(all_eligible(asker)))
    }
    result.to_json
  end

  def jsonify_ineligible(asker)
    result = {
      asker: asker.attributes,
      aids: whitelist(displayable_hash(all_ineligible(asker)))
    }
    result.to_json
  end

  def jsonify_uncertain(asker)
    result = {
      asker: asker.attributes,
      aids: whitelist(displayable_hash(all_uncertain(asker)))
    }
    result.to_json
  end

private
  def whitelist(aids)
    aids.map {|aid| WhitelistAidService.new.for_aid_in_list(aid)}
  end
  def displayable_hash(aids)
    ResultService.new.convert_to_displayable_hash(aids)
  end
  def all_eligible(asker)
    # AidService.all_eligible(asker)
    {}
  end
  def all_ineligible(asker)
    # AidService.all_ineligible(asker)
    {}
  end
  def all_uncertain(asker)
    # AidService.all_uncertain(asker)
    {}
  end

end
