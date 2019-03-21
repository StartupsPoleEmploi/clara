require 'uri'
require 'net/http'
require 'json'

class GetZipCityRegion


  def call(citycode)
    if (citycode && citycode.is_a?(String) && !citycode.blank?)
      escaped_address = URI.escape(ENV['ARA_URL_BAN'] + "rue&citycode=" + citycode) 
      uri = URI.parse(escaped_address)
      response = HttpService.get_instance.get(uri)
      if !response.blank? && response.include?("timeout")
        return 'erreur_service_indisponible'
      elsif !response.blank?
        begin
          props = JSON.parse(response)["features"][0]["properties"]
          if props["postcode"] != nil && props["city"] != nil && props["context"] != nil
            region = props["context"].split(", ").last
            return [props["postcode"], props["city"], region]
          else
            return "erreur_ville_introuvable"
          end
        rescue
          return "erreur_ville_introuvable"
        end
      else
        return 'erreur_communication'
      end
    else
      return 'erreur_technique'
    end
  end
  
end
