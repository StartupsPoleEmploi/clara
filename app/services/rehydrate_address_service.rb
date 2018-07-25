class RehydrateAddressService

  def from_citycode!(asker)
    return asker unless asker.is_a?(Asker) && asker.v_location_citycode != nil
    asker.v_zrr = ZrrService.new.zrr?(asker.v_location_citycode)
    asker
  end

end
