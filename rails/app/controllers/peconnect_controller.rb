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
    if _user_cancelled_peconnect
      redirect_to root_path
    else
      render locals: BuildCallbackHash.new.call(session, params, request)
    end
  end

  def _user_cancelled_peconnect
    copy_url = request.original_url 
    uri    = URI.parse(copy_url)
    query_params = CGI.parse(uri.query)
    p '- - - - - - - - - - - - - - query_params- - - - - - - - - - - - - - - -' 
    ap query_params
    p ''
    query_params.size == 1 && !!query_params['state']
  end


end


  
