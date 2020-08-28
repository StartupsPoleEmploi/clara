module HeaderHelper

  def display_disconnect_button?(session=session, request=request)
    !!(session[:id_token] && request.path != peconnect_callback_path)
  end

end
