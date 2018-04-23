class GoBackController < ApplicationController
  
  before_action: require_asker

  def go
    redirect_to QuestionManager.new.getPreviousPath(request.referer, @asker)
  end

end
