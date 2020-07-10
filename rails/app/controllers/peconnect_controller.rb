require 'digest/sha1'
class PeconnectController < ApplicationController
  
  def question
    redirect_to peconnect_callback_path
  end

  def callback
    render locals: BuildCallbackHash.new.call(session, params, request)
  end

end


  
