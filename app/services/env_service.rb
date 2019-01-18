require 'uri'
require 'net/http'
require 'json'

# deprecated. Try to use ENV[] directly.
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
    
  def ara_url_ban
    ENV['ARA_URL_BAN'] || ''
  end
    
  def ara_google_analytics_id
    ENV['ARA_GOOGLE_ANALYTICS_ID'] || ''
  end
  
  def ara_google_analytics_collect
    ENV['ARA_GOOGLE_ANALYTICS_COLLECT'] || 'https://www.google-analytics.com/collect'
  end
  
end
