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
    # a = Aid.activated.to_json(:include => :contract_type)
    a = CacheService.get_instance.read("all_activated_aids")
    @all_activated_hash = JSON.parse(a)
  end

  def go(asker)
    @all_activated_hash
  end

end
