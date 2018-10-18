class AidCalculationService

  class << self
    protected :new
  end
  
  @@the_double = nil

  def AidCalculationService.get_instance(asker)
    @@the_double.nil? ? AidCalculationService.new(asker) : @@the_double
  end

  def initialize(asker)
    aids_as_hash = ActivatedModelsService.instance.aids
    @calculated_aids_as_hash =  aids_as_hash.map do |aid_as_hash|
      eligibility = RuletreeService.new.resolve(aid_as_hash["rule_id"], asker.attributes)
      aid_as_hash["eligibility"] = eligibility
      # p '- - - - - - - - - - - - - - aid_as_hash- - - - - - - - - - - - - - - -' 
      # pp aid_as_hash
      # p ''
      aid_as_hash
    end
  end

  def every_eligible
    _every_aids_that_are("eligible")
  end

  def every_uncertain
    _every_aids_that_are("uncertain")
  end

  def every_ineligible
    _every_aids_that_are("ineligible")
  end

  def _every_aids_that_are(status)
    _all_aids.select { |a| a["eligibility"] == status }.map { |e| e.select { |key, _| _wanted_keys.include? key }  }
  end

  def _wanted_keys
    %w[id name slug slug short_description ordre_affichage contract_type_id eligibility filters level3_filters]
  end

  def _all_aids
    @calculated_aids_as_hash
  end


end
