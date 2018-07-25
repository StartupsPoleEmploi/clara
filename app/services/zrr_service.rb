require 'uri'
require 'net/http'
require 'json'

class ZrrService

  def zrr?(citycode)
    
    ActivatedModelsService.get_instance.zrr?(citycode.to_s) ? "oui" : "non"

    # if (citycode && citycode.is_a?(String) && !citycode.blank?)
    #   escaped_address = URI.escape(@base_url + "/#{citycode}") 
    #   uri = URI.parse(escaped_address)
    #   response = HttpService.get_instance.get(uri)
    #   if !response.blank? && response.include?("timeout")
    #     return 'service_indisponible'
    #   elsif !response.blank? && response.include?("{\"id\":\"#{citycode}\"}")
    #     return 'en_zrr'
    #   elsif !response.blank? && !response.include?("id")
    #     return 'hors_zrr'
    #   else
    #     return 'erreur_communication'
    #   end
    # else
    #   return 'erreur_technique'
    # end
  end
  
end
