class HydrateAddress < ClaraService
  initialize_with_keywords :asker_attributes
  is_callable

  def call
    unless _valid_args
      raise ArgumentError.new("Arguments must be attributes of an Asker")
    end
    output_asker = Asker.new(@asker_attributes)
    citycode = output_asker.v_location_citycode
    p '- - - - - - - - - - - - - - citycode- - - - - - - - - - - - - - - -' 
    pp citycode
    pp citycode.blank?
    p ''
    zipcode = output_asker.v_location_zipcode
    p '- - - - - - - - - - - - - - zipcode- - - - - - - - - - - - - - - -' 
    pp zipcode
    pp zipcode.present?
    p ''
    return output_asker if citycode.blank?
    return output_asker if zipcode.present?
    p '- - - - - - - - - - - - - - RehydrateAddressService inside- - - - - - - - - - - - - - - -' 
    p ''
    output_asker.v_zrr = IsZrr.call(citycode: citycode)
    zip_city_region = GetZipCityRegion.call(citycode: citycode)
    got_them = zip_city_region.is_a?(Array)
    output_asker.v_location_zipcode = got_them ? zip_city_region[0] : nil
    output_asker.v_location_city = got_them ? zip_city_region[1] : nil
    output_asker.v_location_label = zip_city_region[0] + " " + zip_city_region[1] if got_them
    output_asker.v_location_state = zip_city_region[2] if got_them
    p '- - - - - - - - - - - - - - output_asker- - - - - - - - - - - - - - - -' 
    pp output_asker
    p ''
    output_asker
  end

  def _valid_args
    @asker_attributes.is_a?(Hash) && Asker.new.attributes.keys.sort == @asker_attributes.keys.sort
  end

end
