
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
    calculator = AidCalculationService.get_instance(asker)
    res =  {
     flat_all_eligible: calculator.every_eligible,
     flat_all_uncertain: calculator.every_uncertain,
     flat_all_ineligible: calculator.every_ineligible,
     flat_all_contract: ContractTypeTreeService.get_instance.all_contract_types,
     asker: asker.attributes
    }
    res
  end

  def jsonify_eligible(asker)
    calculator = AidCalculationService.get_instance(asker)
    result = {
      asker: asker.attributes,
      aids: whitelist(calculator.all_eligible)
    }
    result.to_json
  end

  def jsonify_ineligible(asker)
    calculator = AidCalculationService.get_instance(asker)
    result = {
      asker: asker.attributes,
      aids: whitelist(calculator.all_ineligible)
    }
    result.to_json
  end

  def jsonify_uncertain(asker)
    calculator = AidCalculationService.get_instance(asker)
    result = {
      asker: asker.attributes,
      aids: whitelist(calculator.all_uncertain)
    }
    result.to_json
  end

private
  def whitelist(aids)
    aids.map {|aid| WhitelistAidService.new.for_aid_in_list(aid)}
  end

end
