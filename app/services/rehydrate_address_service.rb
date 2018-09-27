class RehydrateAddressService

  def from_citycode!(asker)
    # pp "********************* from_citycode! ***********************"
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil
    CalculateAskerService.new(asker).calculate_zrr!
    zip_city_region = BanService.get_instance.get_zip_city_region(asker.v_location_citycode)
    got_them = zip_city_region.is_a?(Array)
    asker.v_location_zipcode = got_them ? zip_city_region[0] : nil
    asker.v_location_city = got_them ? zip_city_region[1] : nil
    asker.v_location_label = zip_city_region[0] + " " + zip_city_region[1] if got_them
    asker.v_location_state = zip_city_region[2] if got_them
    asker
  end

end
