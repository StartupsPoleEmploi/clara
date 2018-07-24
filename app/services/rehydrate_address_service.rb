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

    asker.v_zrr = ZrrService.get_instance.isZRR(asker.v_location_citycode) 

    asker
  end

  private
  def qpv_args(asker)
    [asker.v_location_street_number, asker.v_location_route, asker.v_location_zipcode, asker.v_location_city]
  end
end
