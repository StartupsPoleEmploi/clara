require 'uri'
require 'securerandom'

class TrackSearchCallService < ClaraService
  initialize_with_keywords :keywords
  is_callable

  def call
    uri = URI.parse(EnvService.get_instance.ara_google_analytics_collect)
    params = {
              "v" => "1",
               "tid" => EnvService.get_instance.ara_google_analytics_id,
               "uid" => SecureRandom.hex,
               "t" => "event",
               "ec" => "search",
               "ea" => @keywords
             }
    HttpService.get_instance.post_form(uri, params)
  end

  end
