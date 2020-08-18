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
    has_state =  ExtractParam.new(params).call("state") != nil
    no_code = ExtractParam.new(params).call("code") == nil
    p '- - - - - - - - - - - - - - no_code- - - - - - - - - - - - - - - -' 
    ap no_code
    p ''
    p '- - - - - - - - - - - - - - has_state- - - - - - - - - - - - - - - -' 
    ap has_state
    p ''
    has_state && no_code
  end


end


  
