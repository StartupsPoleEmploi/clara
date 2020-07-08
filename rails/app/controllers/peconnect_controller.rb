require 'digest/sha1'
class PeconnectController < ApplicationController

  def index
    @built_url = ''
  end

  def callback

    code = ExtractParam.new(params).call("code")
    base_url = "https://#{request.host}"    

    access_token = PeConnectAccessToken.new.call(base_url, code)

    info = PeConnectInfo.new.call(access_token)
    statut = PeConnectStatut.new.call(access_token)
    ap '*************************************************************************************'
    ap info
    ap statut
    hydrate_view({
      "family_name" => info["family_name"],
      "given_name" => info["given_name"],
      "code_statut_individu" => statut["codeStatutIndividu"],
      "libelle_statut_individu" => statut["libelleStatutIndividu"],
    }.with_indifferent_access)
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

  def get_statut(access_token)
    url = URI.parse('https://api.emploi-store.fr/partenaire/peconnect-statut/v1/statut')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Authorization"] = "Bearer #{access_token}"
    response = http.request(req)
    ap response.body
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


