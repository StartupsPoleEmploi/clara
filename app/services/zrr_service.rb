require 'uri'
require 'net/http'
require 'json'

class ZrrService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def ZrrService.set_instance(the_double)
    @@the_double = the_double
  end

  def ZrrService.get_instance
    @@the_double.nil? ? ZrrService.new : @@the_double
  end
  
  def initialize
    @base_url = EnvService.get_instance.ara_url_qpvzrr
    @base_url = @base_url + '/zrr/zrrs'
  end

  def isZRR(citycode)
    
    if (citycode && citycode.is_a?(String) && !citycode.blank?)
      escaped_address = URI.escape(@base_url + "/#{citycode}") 
      uri = URI.parse(escaped_address)
      response = HttpService.get_instance.get(uri)
      if !response.blank? && response.include?("timeout")
        return 'service_indisponible'
      elsif !response.blank? && response.include?("{\"id\":\"#{citycode}\"}")
        return 'en_zrr'
      elsif !response.blank? && !response.include?("id")
        return 'hors_zrr'
      else
        return 'erreur_communication'
      end
    else
      return 'erreur_technique'
    end
  end
  
end
