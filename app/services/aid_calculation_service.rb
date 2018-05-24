
class AidCalculationService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def AidCalculationService.set_instance(the_double)
    @@the_double = the_double
  end

  def AidCalculationService.get_instance
    @@the_double.nil? ? AidCalculationService.new : @@the_double
  end

end
