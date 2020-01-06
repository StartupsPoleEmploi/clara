require 'uri'
require 'net/http'
require 'json'

class GetZipCityRegion


  def call(citycode)
    if (citycode && citycode.is_a?(String) && !citycode.blank?)
      escaped_address = URI.escape(ENV['ARA_URL_GEO_API'] + "communes/#{citycode}") 
      uri = URI.parse(escaped_address)
      response = HttpService.get_instance.get(uri)
      if !response.blank? && response.include?("timeout")
        return 'erreur_service_indisponible'
      elsif !response.blank?
        begin
          props = JSON.parse(response)
          if props && props["nom"]
            return [props["codesPostaux"][0], props["nom"], props["codeRegion"]]
          else
            return "erreur_ville_introuvable"
          end
        rescue
          return "erreur_ville_introuvable2"
        end
      else
        return 'erreur_communication'
      end
    else
      return 'erreur_technique'
    end
  end
  
end
