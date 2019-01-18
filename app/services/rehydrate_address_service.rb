class RehydrateAddressService

  def from_citycode!(asker)
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil && !asker.v_location_zipcode.blank?
    p '- - - - - - - - - - - - - - RehydrateAddressService inside- - - - - - - - - - - - - - - -' 
    p ''
    citycode = asker.v_location_citycode
    asker.v_zrr = IsZrr.call(citycode: citycode)
    zip_city_region = GetZipCityRegion.call(citycode: citycode)
    got_them = zip_city_region.is_a?(Array)
    asker.v_location_zipcode = got_them ? zip_city_region[0] : nil
    asker.v_location_city = got_them ? zip_city_region[1] : nil
    asker.v_location_label = zip_city_region[0] + " " + zip_city_region[1] if got_them
    asker.v_location_state = zip_city_region[2] if got_them
    p '- - - - - - - - - - - - - - asker- - - - - - - - - - - - - - - -' 
    pp asker
    p ''
    asker
  end

end
