require 'uri'
require 'net/http'
require 'json'
require 'timeout'

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

  def for_endpoint(endpoint, values)
    uri = URI.parse("http://www.google-analytics.com/collect")
    json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
    params = {"v" => "1",
      "tid" => EnvService.get_instance.ara_google_analytics_id,
      "cid" => "555",
      "t" => "event",
      "ec" => "API",
      "ea" => "request",
      "el" => endpoint,
      "ev" => values}
    HttpService.get_instance.post(uri.scheme, uri.host, uri.port, uri.path, params.to_json, json_headers)

  end

  end
