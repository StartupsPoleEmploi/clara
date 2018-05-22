class RuletreeService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def RuletreeService.set_instance(the_double)
    @@the_double = the_double
  end

  def RuletreeService.get_instance
    @@the_double.nil? ? RuletreeService.new : @@the_double
  end

  def resolve(rule_id)
  end

  def _all_rules
  end

end
