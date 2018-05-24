
class AidCalculationService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def AidCalculationService.set_instance(the_double)
    @@the_double = the_double
  end

  def AidCalculationService.get_instance(asker)
    @@the_double.nil? ? AidCalculationService.new(asker) : @@the_double
  end

  def initialize(asker)
    aids_as_hash = AidtreeService.get_instance.go(asker)

    @calculated_aids_as_hash =  aids_as_hash.map do |aid_as_hash|  
      eligibility = RuletreeService.get_instance.resolve(aid_as_hash["rule_id"], asker.attributes)
      aid_as_hash["eligibility"] = eligibility
      aid_as_hash
    end
  end

  def all_eligible
    result_service = ResultService.new
    @calculated_aids_as_hash
      .select { |calculated_aid_as_hash| calculated_aid_as_hash["eligibility"] == "eligible" }
      .map { |calculated_aid_as_hash| result_service.convert_to_displayable(calculated_aid_as_hash) }
  end

  def all_ineligible
    result_service = ResultService.new
    @calculated_aids_as_hash
      .select { |calculated_aid_as_hash| calculated_aid_as_hash["eligibility"] == "ineligible" }
      .map { |calculated_aid_as_hash| result_service.convert_to_displayable(calculated_aid_as_hash) }
  end

  def all_uncertain
    result_service = ResultService.new
    @calculated_aids_as_hash
      .select { |calculated_aid_as_hash| calculated_aid_as_hash["eligibility"] == "uncertain" }
      .map { |calculated_aid_as_hash| result_service.convert_to_displayable(calculated_aid_as_hash) }
  end

  def _all_aids
    @calculated_aids_as_hash
  end

end
