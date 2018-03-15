class RehydrateAddressService

  def from_citycode!(asker)
    return Asker.new unless asker.is_a?(Asker)

    zipcode_and_cityname = BanService.get_instance.get_zipcode_and_cityname(asker.v_location_citycode)
    p '- - - - - - - - - - - - - - zipcode_and_cityname- - - - - - - - - - - - - - - -' 
    p zipcode_and_cityname.inspect
    p ''

    if zipcode_and_cityname.is_a?(Array)
      asker.v_location_zipcode  = zipcode_and_cityname[0]
      asker.v_location_city  = zipcode_and_cityname[1]
    end
    asker
  end
end
