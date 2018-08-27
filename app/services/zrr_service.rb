require 'uri'
require 'net/http'
require 'json'

class ZrrService

  def zrr?(citycode) 
    str_val = citycode.to_s
    five_digits_only = /\A\d{5}\z/
    has_5_digits = !!str_val.match(five_digits_only)
    return false unless has_5_digits
    # full_url = "https://qpvzrr.herokuapp.com/zrr/zrrs/#{citycode}"
    # escaped_address = URI.escape(full_url) 
    # uri = URI.parse(escaped_address)
    # response = HttpService.get_instance.get(uri)
    # zrrs = response.to_s
    # zrrs && zrrs.include?(citycode) ? "oui" : "non"
    zrrs = Rails.cache.fetch("zrrs") do
      Zrr.first ? Zrr.first.value  : ""
    end
    zrrs && zrrs.include?(citycode) ? "oui" : "non"
  end
  

end
