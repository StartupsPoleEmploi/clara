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
    p '- - - - - - - - - - - - - - for_endpoint- - - - - - - - - - - - - - - -' 
    p ''
    uri = URI.parse(EnvService.get_instance.ara_google_analytics_collect)
    json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
    params = {"v" => 1,
      "tid" => EnvService.get_instance.ara_google_analytics_id,
      "cid" => 555,
      "t" => "event",
      "ec" => "API",
      "ea" => endpoint,
      "el" => who,
      "ev" => 1}
    HttpService.get_instance.post(uri.scheme, uri.host, uri.port, uri.path, params.to_json, json_headers)

  end

  end
