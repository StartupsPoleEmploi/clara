class RehydrateAddressService

  def from_citycode!(asker)
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil
    CalculateAskerService.new(asker).calculate_zrr!
    zip_and_city = BanService.get_instance.get_zipcode_and_cityname(asker.v_location_citycode)
    got_them = zip_and_city.is_a?(Array)
    asker.v_location_zipcode = got_them ? zip_and_city[0] : nil
    asker.v_location_city = got_them ? zip_and_city[1] : nil
    asker.v_location_label = zip_and_city[0] + " " + zip_and_city[1] if got_them
    asker
  end

end
