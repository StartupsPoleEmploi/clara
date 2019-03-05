class RecordRegister

  def call(session, asker, url)
    city_key = asker.v_location_citycode
    if city_key.is_a?(String) && city_key.start_with?("34")
      Register.new(
        user: session.id,
        geo:  asker.v_location_citycode,
        url: url,
        moment: DateTime.now.strftime("%d-%m-%Y"),
      )
    end
  end
  
end
