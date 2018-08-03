class RehydrateAddressService

  def from_citycode!(asker)
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil
    CalculateAskerService.new(asker).calculate_zrr!
    BanService.get_instance.get_zipcode_and_cityname(asker)
    asker
  end

end
