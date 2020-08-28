class DisconnectFromPeconnect

  def call(request, session, params)
    res = {method: '', arg: nil}
    old_token = session[:id_token]
    session.clear
    redirection_url = UrlAfterDisconnect.new.call(old_token, request.host)
    if params[:json]
      res[:method] = 'render'
      res[:arg] = {json: {redirection_url: redirection_url}}
    else
      res[:method] = 'redirect_to'
      res[:arg] = redirection_url
    end  
    res
  end

end
