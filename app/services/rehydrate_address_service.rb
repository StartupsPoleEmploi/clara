class RehydrateAddressService

  def from_citycode!(asker)
    return Asker.new unless asker.is_a?(Asker)

    zipcode_and_cityname = BanService.get_instance.get_zipcode_and_cityname(asker.v_location_citycode)
    p '- - - - - - - - - - - - - - zipcode_and_cityname- - - - - - - - - - - - - - - -' 
    p zipcode_and_cityname.inspect
    p ''

    if zipcode_and_cityname.is_a?(String) && zipcode_and_cityname.include?("erreur_") 
      return asker
    end
    
    # asker.v_location_state         = address.state
    # asker.v_location_label         = address.label
    # asker.v_location_route         = address.route
    # asker.v_location_city          = address.city
    # asker.v_location_country       = address.country
    # asker.v_location_zipcode       = address.zipcode
    # asker.v_location_citycode      = address.citycode
    # asker.v_location_street_number = address.street_number
    # asker.v_location_state         = address.state
  end
end
