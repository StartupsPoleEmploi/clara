require 'uri'
require 'net/http'
require 'json'

class EnvService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def EnvService.set_instance(the_double)
    @@the_double = the_double
  end

  def EnvService.get_instance
    @@the_double.nil? ? EnvService.new : @@the_double
  end
  
  def ara_url_qpvzrr
    ENV['ARA_URL_QPVZRR'] || ''
  end
  
end
