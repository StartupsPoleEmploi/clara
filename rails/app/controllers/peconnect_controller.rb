require 'digest/sha1'
class PeconnectController < ApplicationController

  def index

    state = Digest::SHA1.hexdigest(rand(1000000000).to_s)
    nonce = Digest::SHA1.hexdigest(rand(1000000000).to_s)

    myparams = {
      'realm' => '/individu',
      'response_type'=>'code',
      'client_id'=>clientid,
      'scope'=>"application_#{clientid} api_peconnect-individuv1 email openid profile",
      'redirect_uri'=>"#{base_url}/peconnect_callback",
      'state'=>state,
      'nonce'=>nonce,
    }

    @built_url = 'https://authentification-candidat.pole-emploi.fr/connexion/oauth2/authorize?'
    @built_url += myparams.to_query

  end

  def callback
    all_params = params.permit(params.keys).to_h.with_indifferent_access
    my_url = 'https://authentification-candidat.pole-emploi.fr/connexion/oauth2/access_token?realm=%2findividu'
    my_form_params = {
      'grant_type' => "authorization_code",
      'code' => all_params[:code],
      'client_id' => clientid,
      'client_secret' => clientsecret,
      'redirect_uri'=>"#{base_url}/peconnect_callback",
    }

    my_uri = URI.parse(my_url)
    my_response = HttpService.new.post_form(my_uri, my_form_params)
    my_parsed = JSON.parse(my_response.body)
    res = get_info(my_parsed["access_token"])
    @info = {
      "family_name" => res["family_name"],
      "given_name" => res["given_name"]
    }
  end

  def clientsecret
    ENV['ESD_CLIENTSECRET']
  end

  def clientid
    ENV['ESD_CLIENTID']
  end

  def incoming_uri
    URI.parse(request.base_url)
  end

  def base_url
    "https://#{incoming_uri.host}"
  end

  def get_info(access_token)
    url = URI.parse('https://api.emploi-store.fr/partenaire/peconnect-individu/v1/userinfo')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Authorization"] = "Bearer #{access_token}"
    response = http.request(req)
    JSON.parse(response.body)
  end

  def post_form(http_client, path, form_params)
    encoded_form = URI.encode_www_form(form_params)
    headers = { content_type: "application/x-www-form-urlencoded" }
    http_client.request_post(path, encoded_form, headers)
  end

  def http_client(host, port)
    http_client = Net::HTTP.new(host, port)
    http_client.read_timeout = 10 # seconds
    http_client.use_ssl = true
    http_client
  end

end


