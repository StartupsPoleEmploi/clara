require 'digest/sha1'
class PeconnectController < ApplicationController

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

end


  
