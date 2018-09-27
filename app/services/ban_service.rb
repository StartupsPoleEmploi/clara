require 'uri'
require 'net/http'
require 'json'

class BanService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def BanService.set_instance(the_double)
    @@the_double = the_double
  end

  def BanService.get_instance
    @@the_double.nil? ? BanService.new : @@the_double
  end
  
  def initialize
    @base_url = EnvService.get_instance.ara_url_ban
    @base_url = @base_url
  end

  def get_zip_city_region(citycode)
    if (citycode && citycode.is_a?(String) && !citycode.blank?)
      escaped_address = URI.escape(@base_url + "rue&citycode=" + citycode) 
      uri = URI.parse(escaped_address)
      response = HttpService.get_instance.get(uri)
      if !response.blank? && response.include?("timeout")
        return 'erreur_service_indisponible'
      elsif !response.blank?
        begin
          props = JSON.parse(response)["features"][0]["properties"]
          if props["postcode"] != nil && props["city"] != nil && props["context"] != nil
            region = props["context"].split(", ").last
            pp '-----------------------------region is ------------------'
            pp props["context"]
            pp region
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
