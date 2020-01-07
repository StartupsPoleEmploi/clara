class HydrateAddress

  def call(asker_attributes)
    unless _valid_args(asker_attributes)
      raise ArgumentError.new("Arguments must be attributes of an Asker")
    end
    p '- - - - - - - - - - - - - - asker_attributes- - - - - - - - - - - - - - - -' 
    pp asker_attributes
    p ''
    output_asker = Asker.new(asker_attributes)
    citycode = output_asker.v_location_citycode
    zipcode = output_asker.v_location_zipcode
    return output_asker if citycode.blank?
    output_asker.v_zrr = IsZrr.new.call(citycode)
    # zip_city_region = GetZipCityRegion.new.call(citycode)
    city_name = GetCityName.new.call(citycode)
    output_asker.v_location_label = zipcode + " " + city_name
    output_asker
  end

  def _valid_args(asker_attributes)
    asker_attributes.is_a?(Hash) && Asker.new.attributes.keys.sort == asker_attributes.keys.sort
  end

end
