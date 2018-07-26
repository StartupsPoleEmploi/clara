require 'uri'
require 'net/http'
require 'json'

class ZrrService

  def zrr?(citycode) 
    str_val = citycode.to_s
    five_digits_only = /\A\d{5}\z/
    has_5_digits = !!str_val.match(five_digits_only)
    zrrs = Rails.cache.fetch('zrrs') {
      full_url = "https://bdavidxyz.github.io/zrrs/"
      escaped_address = URI.escape(full_url) 
      uri = URI.parse(escaped_address)
      response = HttpService.get_instance.get(uri)
      response.to_s
    }
    has_5_digits && zrrs && zrrs.include?(citycode) ? "oui" : "non"
  end
  
end
