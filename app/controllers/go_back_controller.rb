class GoBackController < ApplicationController
  
  def go
    redirect_to QuestionManager.new.getPreviousPath(request.referer, require_asker)
  end

end
