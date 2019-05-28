require 'uri'
require 'securerandom'
require 'net/http'

class TrackSearch
  
  def call(user_search)
    if user_search.is_a?(String) && !user_search.blank?
      uri = URI.parse(ENV['ARA_GOOGLE_ANALYTICS_COLLECT'])
      params = {
                "v" => "1",
                 "tid" => ENV['ARA_GOOGLE_ANALYTICS_ID'] ,
                 "uid" => SecureRandom.hex,
                 "t" => "event",
                 "ec" => "aids",
                 "ea" => "search",
                 "el" => user_search,
               }
      Net::HTTP.post_form(uri, params)
      # HttpService.get_instance.post_form(uri, params)
    else
      "not called"
    end
  end

end
