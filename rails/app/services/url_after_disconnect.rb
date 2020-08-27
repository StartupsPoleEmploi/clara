class UrlAfterDisconnect

  def call(old_token, request_host)
    "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request_host}"
  end
  
end
