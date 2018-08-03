class RehydrateAddressService

  def from_citycode!(asker)
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil
    CalculateAskerService.new(asker).calculate_zrr!
    res = BanService.get_instance.get_zipcode_and_cityname(asker)
    asker.v_location_zipcode = res.is_a?(Array) ? res[0] : nil
    asker.v_location_city = res.is_a?(Array) ? res[1] : nil
  end

end
