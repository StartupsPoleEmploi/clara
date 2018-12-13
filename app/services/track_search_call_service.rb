require 'uri'
require 'securerandom'

class TrackSearchCallService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def TrackSearchCallService.set_instance(the_double)
    @@the_double = the_double
  end

  def TrackSearchCallService.get_instance
    @@the_double.nil? ? TrackSearchCallService.new : @@the_double
  end 

  def for_endpoint(keywords)
    uri = URI.parse(EnvService.get_instance.ara_google_analytics_collect)
    params = {
               "v" => "1",
               "tid" => EnvService.get_instance.ara_google_analytics_id,
               "uid" => SecureRandom.hex,
               "t" => "event",
               "ec" => "search",
               "ea" => keywords
             }
    HttpService.get_instance.post_form(uri, params)
  end

  end
