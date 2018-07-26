require 'uri'
require 'net/http'
require 'json'

class ZrrService

  def zrr?(citycode) 
    full_url = "https://bdavidxyz.github.io/zrrs/"
    escaped_address = URI.escape(full_url) 
    uri = URI.parse(escaped_address)
    response = HttpService.get_instance.get(uri)

    response && response.include?('citycode') ? "oui" : "non"
  end
  
end
