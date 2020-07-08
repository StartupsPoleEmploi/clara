class PeConnectUrl < PeConnectService

  def call(base_url)
    state = Digest::SHA1.hexdigest(rand(1000000000).to_s)
    nonce = Digest::SHA1.hexdigest(rand(1000000000).to_s)

    myparams = {
      'realm' => '/individu',
      'response_type'=>'code',
      'client_id'=>clientid,
      'scope'=>"application_#{clientid} api_peconnect-individuv1 email openid profile api_peconnect-statutv1 statut api_peconnect-datenaissancev1 datenaissance api_peconnect-formationsv1 pfcformations api_peconnect-coordonneesv1 coordonnees api_peconnect-indemnisationsv1 indemnisation",
      'redirect_uri'=>"#{base_url}/peconnect_callback",
      'state'=>state,
      'nonce'=>nonce,
    }

    "#{myparams.to_query}"
  end


 end
