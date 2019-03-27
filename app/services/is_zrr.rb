require 'uri'
require 'net/http'
require 'json'

class IsZrr

  def call(citycode)
    str_val = citycode.to_s
    five_digits_only = /\A\d{5}\z/
    has_5_digits = !!str_val.match(five_digits_only)
    return nil unless has_5_digits
    zrrs = Rails.cache.fetch("zrrs") do
      res = ""
      if Zrr.first
        res = Zrr.first.value 
      else
        res = ""
      end
      res  
    end
    zrrs && zrrs.include?(str_val) ? "oui" : "non"
  end
  
end
