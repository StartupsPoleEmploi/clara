class FilterQuestionsController < ApplicationController
  
  before_action :require_asker, only: [:new, :create]

  def new
  end

  def create
    p '- - - - - - - - - - - - - - create- - - - - - - - - - - - - - - -' 
    p ''
    if params[:commit] == 'Revenir' 
      my_redirect_to QuestionManager.new.getPreviousPath('filter', @asker)
    else
      redirect_to_next_question(request)
    end
  end
  
private

  def redirect_to_next_question(request)
    base64_str = TranslateB64AskerService.new.into_b64(@asker)
    my_redirect_to QuestionManager.new.getNextPath('filter', base64_str)
  end

  def allowed_params
  end

end
