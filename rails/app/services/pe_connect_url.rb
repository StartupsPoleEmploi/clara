class PeConnectUrl

  def call(incoming_uri)
    state = Digest::SHA1.hexdigest(rand(1000000000).to_s)
    nonce = Digest::SHA1.hexdigest(rand(1000000000).to_s)

    myparams = {
      'realm' => '/individu',
      'response_type'=>'code',
      'client_id'=>clientid,
      'scope'=>"application_#{clientid} api_peconnect-individuv1 email openid profile",
      'redirect_uri'=>"#{base_url(incoming_uri)}/peconnect_callback",
      'state'=>state,
      'nonce'=>nonce,
    }

    "https://authentification-candidat.pole-emploi.fr/connexion/oauth2/authorize?#{myparams.to_query}"
  end
 
  def peconnect_oauth2_auth
    # Do not work currently
    # ENV['PECONNECT_OAUTH2_AUTH']
  end

  def clientsecret
    ENV['ESD_CLIENTSECRET']
  end

  def clientid
    ENV['ESD_CLIENTID']
  end

  def base_url(incoming_uri)
    "https://#{incoming_uri.host}"
  end

 end
