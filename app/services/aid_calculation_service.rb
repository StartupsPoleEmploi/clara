
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
    p '- - - - - - - - - - - - - - initialize- - - - - - - - - - - - - - - -' 
    p ''
    aids_as_hash = AidtreeService.get_instance.go(asker)
    p '- - - - - - - - - - - - - - aids_as_hash- - - - - - - - - - - - - - - -' 
    pp aids_as_hash
    p ''

    @calculated_aids_as_hash =  aids_as_hash.map do |aid_as_hash|  
      eligibility = RuletreeService.get_instance.resolve(aid_as_hash["rule_id"], asker.attributes)
      aid_as_hash["eligibility"] = eligibility
      aid_as_hash
    end
    p '- - - - - - - - - - - - - - calculated_aids_as_hash- - - - - - - - - - - - - - - -' 
    pp @calculated_aids_as_hash
    p ''

    # aids_as_hash.each do |aid_as_hash|  
    #   eligibility = RuletreeService.get_instance.resolve(aid_as_hash["rule_id"], asker.attributes)
    #   aid_as_hash["eligibility"] = eligibility
    # end
  end

  def _all_aids
    @calculated_aids_as_hash
  end

end
