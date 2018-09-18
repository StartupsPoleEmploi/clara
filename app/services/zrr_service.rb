require 'uri'
require 'net/http'
require 'json'

class ZrrService

  def zrr?(citycode)
    false_value = "non" 
    true_value = "oui" 
    str_val = citycode.to_s
    five_digits_only = /\A\d{5}\z/
    has_5_digits = !!str_val.match(five_digits_only)
    return nil unless has_5_digits
    zrrs = Rails.cache.fetch("zrrs") do
      Zrr.first ? Zrr.first.value  : ""
    end
    zrrs && zrrs.include?(citycode) ? true_value : false_value
  end
  

end
