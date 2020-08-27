class DisconnectFromPeconnect

  def call(request, session, params)
    res = {method: '', arg: nil}
    old_token = session[:id_token]
    session.clear
    if params[:json]
      res[:method] = 'render'
      res[:arg] = {json: {redirection_url: "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request.host}"}}
      # render json: {redirection_url: "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request.host}"}
    else
      res[:method] = 'redirect_to'
      res[:arg] = "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request.host}"
      # redirect_to "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{old_token}&redirect_uri=https://#{request.host}"
    end  
    res
  end

end
