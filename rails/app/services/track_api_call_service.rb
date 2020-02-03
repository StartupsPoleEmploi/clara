require 'uri'

class TrackApiCallService

  def for_endpoint(endpoint, who)
    uri = URI.parse(EnvService.get_instance.ara_google_analytics_collect)
    params = {"v" => "1",
               "tid" => EnvService.get_instance.ara_google_analytics_id,
               "cid" => "555",
               "t" => "event",
               "ec" => "API",
               "ea" => endpoint,
               "el" => _tracked(who),
               "ev" => 1}
    HttpService.new.post_form(uri, params)
  end

  def _tracked(who)
    return who unless !who.is_a?(String)
    res = "user_not_found@clara.com"
    if who
      res = "email_not_found@clara.com"
      if who.try(:email)
        res = who.email
      end
    end
    res
  end

end
