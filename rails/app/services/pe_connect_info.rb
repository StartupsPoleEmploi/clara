class PeConnectInfo < PeConnectService

  def call(access_token)
    url = URI.parse('https://api.emploi-store.fr/partenaire/peconnect-individu/v1/userinfo')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Authorization"] = "Bearer #{access_token}"
    response = http.request(req)
    JSON.parse(response.body)
  end


 end
