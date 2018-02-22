class GoBackController < ApplicationController
  
  def go
    redirect_to QuestionManager.new.getPreviousPath(request.referer)
  end

end
