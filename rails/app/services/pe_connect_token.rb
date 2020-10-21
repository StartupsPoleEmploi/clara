class PeConnectToken < PeConnectService

  def call(base_url, code)
    my_url = 'https://authentification-candidat.pole-emploi.fr/connexion/oauth2/access_token?realm=%2findividu'
    my_form_params = {
      'grant_type' => "authorization_code",
      'code' => code,
      'client_id' => clientid,
      'client_secret' => clientsecret,
      'redirect_uri'=>"#{base_url}/peconnect_callback",
    }

    my_uri = URI.parse(my_url)
    my_response = HttpService.new.post_form(my_uri, my_form_params)
    my_parsed = JSON.parse(my_response.body)
    access_token = my_parsed["access_token"]
    id_token = my_parsed["id_token"]
    claim_sub = _extract_sub(id_token)
    RecordPeid.new.call(claim_sub)
    {
      id_token: id_token,
      access_token: access_token
    }
  end


  def _extract_sub(id_token)
    claim_as_str = Base64.decode64(id_token.try(:split, '.').try(:[], 1))
    claim = {}
    if IsValidJson.new.call(claim_as_str)
      claim = JSON.parse(claim_as_str)
    end
    claim['sub']
  end


 end
