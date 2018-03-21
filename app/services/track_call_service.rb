require 'uri'

class TrackCallService

  class << self
    protected :new
  end

  @@the_double = nil

  # Allow DI for testing purpose
  def TrackCallService.set_instance(the_double)
    @@the_double = the_double
  end

  def TrackCallService.get_instance
    @@the_double.nil? ? TrackCallService.new : @@the_double
  end

  def for_endpoint(endpoint, who)
    uri = URI.parse(EnvService.get_instance.ara_google_analytics_collect)
    params = {"v" => "1",
               "tid" => EnvService.get_instance.ara_google_analytics_id,
               "cid" => "555",
               "t" => "event",
               "ec" => "API",
               "ea" => endpoint,
               "el" => who,
               "ev" => 1}
    HttpService.get_instance.post_form(uri, params)
  end

  end
