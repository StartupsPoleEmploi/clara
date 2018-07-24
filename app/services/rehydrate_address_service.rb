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
    p '- - - - - - - - - - - - - - asker- - - - - - - - - - - - - - - -' 
    pp asker
    p ''

    # zipcode_and_cityname = BanService.get_instance.get_zipcode_and_cityname(asker.v_location_citycode)

    # if zipcode_and_cityname.is_a?(Array)
    #   asker.v_location_zipcode  = zipcode_and_cityname[0]
    #   asker.v_location_city  = zipcode_and_cityname[1]
    #   if QpvService.get_instance.setDetailedQPV(*qpv_args(asker))
    #     asker.v_qpv = QpvService.get_instance.isDetailedQPV(*qpv_args(asker)) 
    #   end
    # end

    asker
  end

  private
  def qpv_args(asker)
    [asker.v_location_street_number, asker.v_location_route, asker.v_location_zipcode, asker.v_location_city]
  end
end
