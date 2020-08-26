require 'digest/sha1'
class PeconnectController < ApplicationController

  def question
    BuildCallbackQuestion.new.call(session, params, request)
    redirect_to peconnect_callback_path(already_connected: true)
  end

  def final
    asker = PullAskerFromSession.new.call(session)
    base64_str = TranslateB64AskerService.new.into_b64(asker)
    redirect_to aides_path + '?for_id=' + base64_str
  end

  def callback
    if HasUserCancelledPeconnect.new.call(request.original_url)
      redirect_to root_path(trigger_popin: true)
    else
      render locals: BuildCallbackHash.new.call(session, params, request.host)
    end
  end

  # def disconnect
  #   session.clear
  #   redirect_to "https://authentification-candidat.pole-emploi.fr/compte/deconnexion?id_token_hint=#{session[:id_token]}&redirect_uri=https://#{request.host}"
  # end

end


  
