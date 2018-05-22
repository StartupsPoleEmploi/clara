class AidtreeService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def AidtreeService.set_instance(the_double)
    @@the_double = the_double
  end

  def AidtreeService.get_instance
    @@the_double.nil? ? AidtreeService.new : @@the_double
  end

  def initialize
  end

  def go(asker)
    
  end

end
