module HeaderHelper

  def display_disconnect_button?(local_session=session, local_request=request)
    !!(local_session[:id_token] && local_request.path != peconnect_callback_path)
  end

end
