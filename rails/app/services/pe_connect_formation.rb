class PeConnectFormation < PeConnectService

  def call(access_token)
    url = URI.parse('https://api.emploi-store.fr/partenaire/peconnect-formations/v1/formations')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Authorization"] = "Bearer #{access_token}"
    response = http.request(req)
    JSON.parse(response.body)
  end


 end