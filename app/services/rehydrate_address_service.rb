class RehydrateAddressService

  class << self
    protected :new
  end
  
  @@the_double = nil

  # Allow DI for testing purpose
  def RehydrateAddressService.set_instance(the_double)
    @@the_double = the_double
  end

  def RehydrateAddressService.get_instance
    @@the_double.nil? ? RehydrateAddressService.new : @@the_double
  end

  def from_citycode!(asker)
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil
    asker.v_zrr = ZrrService.new.zrr?
    asker
  end

end
