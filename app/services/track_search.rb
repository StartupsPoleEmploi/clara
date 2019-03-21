require 'uri'
require 'securerandom'

class TrackSearch
  
  def call(user_search)
    if user_search.is_a?(String) && !user_search.blank?
      uri = URI.parse(EnvService.get_instance.ara_google_analytics_collect)
      params = {
                "v" => "1",
                 "tid" => EnvService.get_instance.ara_google_analytics_id,
                 "uid" => SecureRandom.hex,
                 "t" => "event",
                 "ec" => "aids",
                 "ea" => "search",
                 "el" => user_search,
               }
      HttpService.get_instance.post_form(uri, params)
    else
      "not called"
    end
  end

end
