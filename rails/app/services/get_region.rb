require 'uri'
require 'net/http'
require 'json'

class GetRegion

  # :nocov:
  def call(regioncode)
    if (regioncode && regioncode.is_a?(String) && !regioncode.blank?)
      escaped_address = URI.escape(ENV['ARA_URL_GEO_API'] + "regions/#{regioncode}") 
      uri = URI.parse(escaped_address)
      response = HttpService.new.get(uri)
      if !response.blank? && response.include?("timeout")
        return 'erreur_service_indisponible'
      elsif !response.blank?
        begin
          props = JSON.parse(response)
          if props && props["nom"]
            return props["nom"]
          else
            return "erreur_region_introuvable"
          end
        rescue
          return "erreur_region_introuvable2"
        end
      else
        return 'erreur_communication'
      end
    else
      return 'erreur_technique'
    end
  end
  # :nocov:
  
end
