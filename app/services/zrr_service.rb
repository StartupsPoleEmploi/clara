require 'uri'
require 'net/http'
require 'json'

class ZrrService

  def zrr?(citycode)
    
    ActivatedModelsService.get_instance.zrr?(citycode.to_s) ? "oui" : "non"

  end
  
end
