
class SleeperService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def SleeperService.set_instance(the_double)
    @@the_double = the_double
  end

  def SleeperService.get_instance
    @@the_double.nil? ? SleeperService.new : @@the_double
  end

  def sleep(n)
    sleep(n)
  end

end
