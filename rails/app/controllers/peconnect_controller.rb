require 'digest/sha1'
class PeconnectController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:final]
  
  def question
    BuildCallbackQuestion.new.call(session, params, request)
    redirect_to peconnect_callback_path
  end

  def final
    asker = PullAskerFromSession.new.call(session)
    base64_str = TranslateB64AskerService.new.into_b64(asker)
    redirect_to aides_path + '?for_id=' + base64_str
  end

  def callback
    p '- - - - - - - - - - - - - - question- - - - - - - - - - - - - - - -' 
    ap session[:meta]
    p ''
    render locals: BuildCallbackHash.new.call(session, params, request)
  end


end


  
