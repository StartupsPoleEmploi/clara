
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
    pp aids_as_hash.inspect
    p ''

  end

  def _all_aids
    
  end

end
