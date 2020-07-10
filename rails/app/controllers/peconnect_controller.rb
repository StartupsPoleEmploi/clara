require 'digest/sha1'
class PeconnectController < ApplicationController

  def index
    @built_url = ''
  end
  
  def post_question_1
  end

  def callback_question_2
  end

  def post_question_2
  end

  def question
    redirect_to peconnect_callback_path
  end

  def callback
    render locals: BuildCallbackHash.new.call(session, params, request)
  end

end


  
