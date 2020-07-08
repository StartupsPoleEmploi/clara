class PeConnectService

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
