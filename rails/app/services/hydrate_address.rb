class HydrateAddress

  def call(asker_attributes)
    unless _valid_args(asker_attributes)
      raise ArgumentError.new("Arguments must be attributes of an Asker")
    end
    output_asker = Asker.new(asker_attributes)
    citycode = output_asker.v_location_citycode || ""
    zipcode = output_asker.v_location_zipcode || ""
    return output_asker if citycode.blank?
    output_asker.v_zrr = IsZrr.new.call(citycode)
    
    city_name_region_code = GetCityNameRegionCode.new.call(citycode)
    city_name = city_name_region_code[0]
    region_code = city_name_region_code[1]
    region_name = GetRegion.new.call(region_code)

    output_asker.v_location_label = zipcode + " " + city_name
    output_asker.v_location_city = city_name
    output_asker.v_location_state = region_name
    output_asker
  end

  def _valid_args(asker_attributes)
    asker_attributes.is_a?(Hash) && Asker.new.attributes.keys.sort == asker_attributes.keys.sort
  end

end
