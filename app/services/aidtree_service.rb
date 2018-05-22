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
    # return [1,2,3,4,5,6]    
    a = Aid.activated.to_json(:include => :contract_type)
    JSON.parse(a)
    # a
    # p '- - - - - - - - - - - - - - a- - - - - - - - - - - - - - - -' 
    # p a.inspect
    # p ''
  end

end
