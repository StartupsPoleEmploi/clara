class PeConnectService

  def call(full_url, access_token)
    url = URI.parse(full_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new(url.request_uri)
    req["Authorization"] = "Bearer #{access_token}"
    response = http.request(req)
    JSON.parse(response.body)
  end

  def peconnect_oauth2_auth
    ENV['PECONNECT_OAUTH2_AUTH']
  end

  def clientsecret
    ENV['ESD_CLIENTSECRET']
  end

  def clientid
    ENV['ESD_CLIENTID']
  end


 end
